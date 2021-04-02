CREATE SCHEMA test_db AUTHORIZATION postgres;

CREATE TABLE test_db.hbc_details
(
    chw_id varchar NOT NULL,
    case_id varchar NOT NULL,
    chw_display_name varchar,
    case_opened_date date,
    eligible_for_hbc varchar,
    reason_for_referral varchar,
    end_home_based_care varchar,
    comorbidity varchar,
    date_of_enrollment_in_hbc date,
    insert_timestamp timestamp,
    update_timestamp timestamp
);


CREATE TABLE test_db.patient_info
(
    case_id varchar NOT NULL,
    patient_birthdate date,
    gender varchar,
    form_id varchar,
    patient_status varchar,
    caregiver_available varchar,
    contact_type varchar,
    insert_timestamp timestamp,
    update_timestamp timestamp
)

CREATE TABLE test_db.case_symptom_details
(
    case_id varchar NOT NULL,
    symptom_name varchar,
    symptom_present varchar,
    insert_timestamp timestamp ,
    update_timestamp timestamp 
)

CREATE TABLE test_db.geographic_details
(
    case_id varchar NOT NULL,
    catchment_area varchar,
    insert_timestamp timestamp,
    update_timestamp timestamp,

)

CREATE TABLE test_db.comorbidity_details
(
    case_id varchar NOT NULL,
    comorbidity_name varchar,
    comorbidity_present varchar,
    insert_timestamp varchar,
    update_timestamp varchar
)
==========================================Tables to be kept as part of metadata  =================================================
If there is any plan to do a role based access then the below tables cam be used:

CREATE TABLE test_db.chw_role_details
(
    chw_id varchar NOT NULL,
    chw_role varchar,
    insert_timestamp timestamp,
    update_timestamp timestamp
);

===============================================Views===========================================================================
=========================================================calculation of the symptom severity===========================================================

create or replace view test_db.symptom_severity_vw as
select b.case_id as case_id,
CASE WHEN b.symptom_name ='{dry_cough,diarrhoea,fatigue,fever,headache,loss_of_appetite,loss_taste_smell,muscle_aches_pains,myalgia,nasal_congestion,nausea_vomiting,rash_discoloration}' then 'severe'
WHEN b.symptom_name ='{dry_cough,fatigue,fever,headache,loss_of_appetite,loss_taste_smell,muscle_aches_pains,myalgia,nasal_congestion,rash_discoloration}' THEN 'moderate'
WHEN b.symptom_name ='{dry_cough,fever}' or b.symptom_name ='{fever}' or b.symptom_name ='{dry_cough}' or b.symptom_name ='{cough}' THEN 'mild' ELSE 'NA'
END severity_name
from(
SELECT
  x.case_id,x.symptom_name,x.insert_timestamp
FROM (
SELECT
    case_id,array_agg(symptom_name ORDER BY symptom_name) as symptom_name,date_trunc('day',insert_timestamp) as insert_timestamp,
    row_number() OVER (PARTITION BY case_id ORDER BY date_trunc('day',insert_timestamp) DESC) AS rownum
  FROM test_db.case_symptom_details where symptom_present = 'yes' group by case_id,date_trunc('day',insert_timestamp)) x where rownum = 1) b ;

=========================================================feq_follow_up_vw===========================================================

create or replace view test_db.feq_follow_up_vw as
select 
fl.case_id as case_id, 
fl.no_of_followup as no_of_followup,
CASE
    WHEN fl.no_of_followup >=1 and fl.no_of_followup<3 THEN 'Atleast 1 Follow up'
    WHEN fl.no_of_followup >=3 and fl.no_of_followup<=7 THEN 'Atleast 3 Follow up'
    WHEN fl.no_of_followup = 0 THEN 'Lost to Follow Up'
END follow_ups
from(
select 
  case_id,
  CASE WHEN  form_id='' THEN 0 ELSE
  array_length(regexp_split_to_array(form_id, ','),1) 
  end no_of_followup
from test_db.patient_info group by case_id,form_id) as fl

=========================================================HBC exit status calculation===========================================================


create or replace view test_db.hbc_exit_status_columns_vw AS
select hbc.case_id as case_id,fld.no_of_followup,hbc.eligible_for_hbc as eligible_for_hbc,hbc.reason_for_referral as reason_for_referral,hbc.end_home_based_care as end_home_based_care
from
(select 
  case_id,
  array_length(regexp_split_to_array(form_id, ';'),1) as no_of_followup
from test_db.patient_info group by case_id,form_id) as fld,test_db.hbc_details as hbc where hbc.case_id=fld.case_id;

create or replace view test_db.hbc_exit_status_vw as
select 
pi.case_id as case_id,
CASE
	WHEN pi.patient_status = 'deceased' THEN 'deceased'
	WHEN vw.no_of_followup = 0 THEN 'lost_to_follow_up'
	WHEN vw.eligible_for_hbc = 'no' and vw.reason_for_referral = 'treatment' THEN 'referred'
	WHEN vw.end_home_based_care= 'yes' THEN 'recovered'
	WHEN vw.end_home_based_care= 'no' or  vw.end_home_based_care= '' or vw.end_home_based_care=NULL and vw.eligible_for_hbc='yes' THEN 'active'
END hbc_exit_status
from test_db.hbc_exit_status_columns_vw as vw, test_db.patient_info as pi where pi.case_id = vw.case_id;

=========================================================fact_details_vw===========================================================
create or replace view test_db.fact_details_vw as
select
 pi.case_id as case_id,
 hbc.chw_id as chw_id,
 symptom_severity_vw.severity_name as severity_name,
 hbc_exit_status_vw.hbc_exit_status as hbc_exit_status,
 geo.catchment_area as catchment_area,
  feq_follow_up_vw.follow_ups as followup_bucket,
  feq_follow_up_vw.no_of_followup as no_of_followup,
  7 as expected_follow_up ,
  hbc.case_opened_date as case_opened_date,
  current_timestamp as insert_timestamp,
  current_timestamp as update_timestamp
from test_db.patient_info as pi,test_db.hbc_details as hbc,test_db.feq_follow_up_vw,test_db.symptom_severity_vw,test_db.hbc_exit_status_vw,test_db.geographic_details as geo
where pi.case_id=hbc.case_id and pi.case_id = hbc_exit_status_vw.case_id and pi.case_id = feq_follow_up_vw.case_id and pi.case_id=geo.case_id and pi.case_id = symptom_severity_vw.case_id;

=========================================================semantic_layer_vw===========================================================
create view test_db.semantic_layer_vw as 
select
fact.chw_id as chw_id,
fact.case_id as case_id,
hbc.chw_display_name as chw_display_name,
fact.case_opened_date as case_opened_date,
hbc.eligible_for_hbc as eligible_for_hbc,
hbc.date_of_enrollment_in_hbc as date_of_enrollment_in_hbc,
CASE
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) >= 0 and date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) <= 10 THEN '0 - 10'
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) >= 11 and date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) <= 20 THEN '11 - 20'
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) > 20 and date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) <= 30 THEN '21 - 30'
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) > 30 and date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) <= 40 THEN '31 - 40'
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) > 40 and date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) <= 50 THEN '41 - 50'
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) > 50 and date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) <= 65 THEN '51 - 65'
    WHEN date_part('year', age(hbc.date_of_enrollment_in_hbc, pi.patient_birthdate)) > 65  THEN '65+' 
END age_group,
pi.gender as gender,
fact.hbc_exit_status as hbc_exit_status,
pi.caregiver_available as caregiver_available,
pi.contact_type as contact_type,
hbc.comorbidity as comorbidity,
fact.severity_name as symptom_severity,
fact.expected_follow_up as expected_follow_up,
fact.no_of_followup as actual_follow_ups_completed,
fact.followup_bucket as followup_bucket,
fact.catchment_area as catchment_area,
CASE
    WHEN hbc.eligible_for_hbc = 'no' and hbc.reason_for_referral = 'treatment' THEN 'referred'
	WHEN hbc.eligible_for_hbc = 'yes' THEN 'Enrolled'
END screening_outcome,
current_timestamp as insert_timestamp ,
current_timestamp as update_timestamp 
from test_db.fact_details_vw as fact,test_db.hbc_details as hbc, test_db.patient_info as pi where fact.case_id = hbc.case_id and fact.case_id=pi.case_id;









