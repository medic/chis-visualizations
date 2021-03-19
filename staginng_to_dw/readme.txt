
Scenario 1.
New column added in the source data follow the below steps:
1. Add the source column details in the source_mapping_details along with it's transformation logic.
2. If the source column is going to sit in an already existing table, then update the table to add the new column in postgres DB.
3. Update the corresponding views along with fact_details and semantic_layer view updatation to accomodate new column.
4. If the new column is required in a specific table which doesn't exist in the star schema then create the table in the star schema and follow the view updation.

Scenario 2.
If the new data requires any transformation which is not there in the existing tranformation rule then follow the below steps to add the logic in the ETL:
1. Build new tranformation logic in a factory class
2. Register new factory class in transformer_factory.py with a new key.
3. Configure the mapping table to have the columns that should undergo new transformation.


Scenarion 3.
Add a new source follow the below steps:
1. Add the source and target connection details in source_details metadata.
2. Add the corresponding source and target table mapping in source_mapping_details metadata.
3. If the source is not DB, then follow the steps described in scenario 2 to get a separate factory pattern for that source type.
4. A separate factory pattern might be required if the data type is not JSON or the load type is other than Full load.

Scenarion 4.
1. As of now, we are getting the form_ids as a list with comma separated values (28fbbe5e-b54f-4cd8-a93f-d31d4a2e3344,adaab35c-0c4d-46bf-a439-ca321c0324b9)
2. The feq_follow_up_vw view to get the count of form_id is being build based on comma separator ( array_length(regexp_split_to_array(form_id, ','),1), so if in the data there is any other separator than comma(,) then this view needs to be modified accordingly
3. Example, if the separator is (;), then the above expression will be modified as (array_length(regexp_split_to_array(form_id, ';'),1)

Insert statement for source_details:
INSERT INTO test_db.source_details(
    run_id, source_name, source_column_details, source_type, source_connection_details, data_format, load_type, load_version, delta_load_condition, update_strategy, target_db_name,target_db_connection_details, processing_needed)
    VALUES (1, 'test_db.dimagi_json_data', 'json_data', 'postgresql','{​​​​​​​"host":"localhost","dbname":"postgres", "user":"postgres", "password":"pdtestdb","port":"5432"}​​​​​​​', 'json', 'full', '1', '', '','postgresql', '{​​​​​​​"host":"localhost","dbname":"postgres", "user":"postgres", "password":"pdtestdb", "port":"5432"}​​​​​​​', 'yes');   


Insert startement for source_mapping_details metadta:
INSERT INTO test_db.source_mapping_details(run_id, source_table, source_column,transformation_rule, target_table, target_column,primary_key,default_value)    VALUES (1,'test_db.dimagi_json_data','case_id','{"rule":"copy"}','test_db.patient_info','case_id','','case1');
INSERT INTO test_db.source_mapping_details(
    run_id, source_table, source_column, transformation_rule, target_table, target_column,
    primary_key)
    VALUES (1, 'test_db.dimagi_json_data', 'case_id,fever', '{"rule":"transpose_column_name_to_row","column_to_transform":"fever"}','test_db.case_symptom_details', '{"case_id":"case_id","symptom_name":"transformed_column_name","symptom_present":"fever"}', '');

 
