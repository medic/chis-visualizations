==================================================source_details=============================================================
CREATE TABLE test_db.source_details
(
run_id integer,
source_name varchar,
source_column_details varchar,
source_type varchar,
source_connection_details varchar,
data_format varchar,
load_type varchar,
load_version integer,
delta_load_condition varchar,
update_strategy varchar,
target_db_name varchar,
target_db_connection_details varchar,
processing_needed varchar,
load_date date
)



INSERT INTO test_db.source_details(
    run_id, source_name, source_column_details, source_type, source_connection_details, data_format, load_type, load_version, delta_load_condition, update_strategy, target_db_name,target_db_connection_details, processing_needed)
    VALUES (1, 'test_db.dimagi_json_data', 'json_data', 'postgresql','{"host":"localhost","dbname":"postgres", "user":"***", "password":"***","port":"5432"}', 'json', 'full', '1', '', '','postgresql', '{"host":"localhost","dbname":"postgres", "user":"***", "password":"***", "port":"5432"}', 'yes');   
	
	
INSERT INTO test_db.source_details(
    run_id, source_name, source_column_details, source_type, source_connection_details, data_format, load_type, load_version, delta_load_condition, update_strategy, target_db_name,target_db_connection_details, processing_needed)
    VALUES (2, 'test_db.medic_json_data', 'json_data', 'postgresql','{"host":"localhost","dbname":"postgres", "user":"***", "password":"***","port":"5432"}', 'json', 'full', '1', '', '','postgresql', '{"host":"localhost","dbname":"postgres", "user":"***", "password":"***", "port":"5432"}', 'yes');   


==================================================source_mapping_details=============================================================
CREATE TABLE test_db.source_mapping_details
(
    run_id integer,
    source_table varchar,
    source_column varchar,
    transformation_rule varchar,
    target_table varchar,
    target_column varchar,
    primary_key varchar,
	default_value varchar
);

INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','user_id','{"rule":"copy"}','test_db.hbc_details','chw_id','','chw1');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','case_id','{"rule":"copy"}','test_db.hbc_details','case_id','','case1');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','chw_name','{"rule":"copy"}','test_db.hbc_details','chw_display_name','','chw_name');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','date_opened','{"rule":"copy"}','test_db.hbc_details','case_opened_date','','0001-01-01');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','eligible_for_hbc','{"rule":"copy"}','test_db.hbc_details','eligible_for_hbc','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','reason_for_referral','{"rule":"copy"}','test_db.hbc_details','reason_for_referral','','reffered');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','end_home_based_care','{"rule":"copy"}','test_db.hbc_details','end_home_based_care','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','has_underlying_condition','{"rule":"copy"}','test_db.hbc_details','comorbidity','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','date_of_enrollment_in_hbc','{"rule":"copy"}','test_db.hbc_details','date_of_enrollment_in_hbc','','0001-01-01');


INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','case_id','{"rule":"copy"}','test_db.patient_info','case_id','','case1');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','patient_date_of_birth','{"rule":"copy"}','test_db.patient_info','patient_birthdate','','0001-01-01');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','patient_sex','{"rule":"copy"}','test_db.patient_info','gender','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','xform_ids','{"rule":"copy"}','test_db.patient_info','form_id','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','patient_status','{"rule":"copy"}','test_db.patient_info','patient_status','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','caregiver_available','{"rule":"copy"}','test_db.patient_info','caregiver_available','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','referral_location','{"rule":"copy"}','test_db.patient_info','contact_type','','na');



INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,fever', '{"rule":"transpose_column_name_to_row","column_to_transform":"fever"}','test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"fever"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,fatigue', '{"rule":"transpose_column_name_to_row","column_to_transform":"fatigue"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"fatigue"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,conjunctivitis', '{"rule":"transpose_column_name_to_row","column_to_transform":"conjunctivitis"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"conjunctivitis"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,headache', '{"rule":"transpose_column_name_to_row","column_to_transform":"headache"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"headache"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,loss_of_appetite', '{"rule":"transpose_column_name_to_row","column_to_transform":"loss_of_appetite"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"loss_of_appetite"}', '');
			
		
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,loss_taste_smell', '{"rule":"transpose_column_name_to_row","column_to_transform":"loss_taste_smell"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"loss_taste_smell"}', '');		
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,muscle_aches_pains', '{"rule":"transpose_column_name_to_row","column_to_transform":"muscle_aches_pains"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"muscle_aches_pains"}', '');				
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,nasal_congestion', '{"rule":"transpose_column_name_to_row","column_to_transform":"nasal_congestion"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"nasal_congestion"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,nausea_vomiting', '{"rule":"transpose_column_name_to_row","column_to_transform":"nausea_vomiting"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"nausea_vomiting"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,dry_cough', '{"rule":"transpose_column_name_to_row","column_to_transform":"dry_cough"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"dry_cough"}', '');
  		
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,rash_discoloration', '{"rule":"transpose_column_name_to_row","column_to_transform":"rash_discoloration"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"rash_discoloration"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,sore_throat', '{"rule":"transpose_column_name_to_row","column_to_transform":"sore_throat"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"sore_throat"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,hiv', '{"rule":"transpose_column_name_to_row","column_to_transform":"hiv"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"hiv"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,chronic_kidney_disease', '{"rule":"transpose_column_name_to_row","column_to_transform":"chronic_kidney_disease"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"chronic_kidney_disease"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,chronic_lung_conditions', '{"rule":"transpose_column_name_to_row","column_to_transform":"chronic_lung_conditions"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"chronic_lung_conditions"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,malnutrition', '{"rule":"transpose_column_name_to_row","column_to_transform":"malnutrition"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"malnutrition"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,severe_obesity', '{"rule":"transpose_column_name_to_row","column_to_transform":"severe_obesity"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"severe_obesity"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,tb', '{"rule":"transpose_column_name_to_row","column_to_transform":"tb"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"tb"}', '');

INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','user_id','{"rule":"copy"}','test_db.hbc_details','chw_id','','chw1');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','case_id','{"rule":"copy"}','test_db.hbc_details','case_id','','case1');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','chw_name','{"rule":"copy"}','test_db.hbc_details','chw_display_name','','chw_name');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','date_opened','{"rule":"copy"}','test_db.hbc_details','case_opened_date','','0001-01-01');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','eligible_for_hbc','{"rule":"copy"}','test_db.hbc_details','eligible_for_hbc','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','reason_for_referral','{"rule":"copy"}','test_db.hbc_details','reason_for_referral','','reffered');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','end_home_based_care','{"rule":"copy"}','test_db.hbc_details','end_home_based_care','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','has_underlying_condition','{"rule":"copy"}','test_db.hbc_details','comorbidity','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','date_of_enrollment_in_hbc','{"rule":"copy"}','test_db.hbc_details','date_of_enrollment_in_hbc','','0001-01-01');


INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','case_id','{"rule":"copy"}','test_db.patient_info','case_id','','case1');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','patient_date_of_birth','{"rule":"copy"}','test_db.patient_info','patient_birthdate','','0001-01-01');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','patient_sex','{"rule":"copy"}','test_db.patient_info','gender','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','xform_ids','{"rule":"copy"}','test_db.patient_info','form_id','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','patient_status','{"rule":"copy"}','test_db.patient_info','patient_status','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','caregiver_available','{"rule":"copy"}','test_db.patient_info','caregiver_available','','na');
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (2,'test_db.medic_json_data','referral_location','{"rule":"copy"}','test_db.patient_info','contact_type','','na');


INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,fever', '{"rule":"transpose_column_name_to_row","column_to_transform":"fever"}','test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"fever"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,fatigue', '{"rule":"transpose_column_name_to_row","column_to_transform":"fatigue"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"fatigue"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,conjunctivitis', '{"rule":"transpose_column_name_to_row","column_to_transform":"conjunctivitis"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"conjunctivitis"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,headache', '{"rule":"transpose_column_name_to_row","column_to_transform":"headache"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"headache"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,loss_of_appetite', '{"rule":"transpose_column_name_to_row","column_to_transform":"loss_of_appetite"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"loss_of_appetite"}', '');
			
		
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,loss_taste_smell', '{"rule":"transpose_column_name_to_row","column_to_transform":"loss_taste_smell"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"loss_taste_smell"}', '');		
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,muscle_aches_pains', '{"rule":"transpose_column_name_to_row","column_to_transform":"muscle_aches_pains"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"muscle_aches_pains"}', '');				
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,nasal_congestion', '{"rule":"transpose_column_name_to_row","column_to_transform":"nasal_congestion"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"nasal_congestion"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,nausea_vomiting', '{"rule":"transpose_column_name_to_row","column_to_transform":"nausea_vomiting"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"nausea_vomiting"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,dry_cough', '{"rule":"transpose_column_name_to_row","column_to_transform":"dry_cough"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"dry_cough"}', '');
			
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,rash_discoloration', '{"rule":"transpose_column_name_to_row","column_to_transform":"rash_discoloration"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"rash_discoloration"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,sore_throat', '{"rule":"transpose_column_name_to_row","column_to_transform":"sore_throat"}',
            'test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"sore_throat"}', '');
			
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,hiv', '{"rule":"transpose_column_name_to_row","column_to_transform":"hiv"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"hiv"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,chronic_kidney_disease', '{"rule":"transpose_column_name_to_row","column_to_transform":"chronic_kidney_disease"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"chronic_kidney_disease"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,chronic_lung_conditions', '{"rule":"transpose_column_name_to_row","column_to_transform":"chronic_lung_conditions"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"chronic_lung_conditions"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,malnutrition', '{"rule":"transpose_column_name_to_row","column_to_transform":"malnutrition"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"malnutrition"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,severe_obesity', '{"rule":"transpose_column_name_to_row","column_to_transform":"severe_obesity"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"severe_obesity"}', '');

INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (2, 'test_db.medic_json_data', 'case_id,tb', '{"rule":"transpose_column_name_to_row","column_to_transform":"tb"}',
            'test_db.comorbidity_details', '{"case_id":"case_id","comorbidity_name":"transformed_column_name","comorbidity_present":"tb"}', '');
