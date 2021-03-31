A.	Steps to setup and run ETL pipeline.

    1.	Download code from git - https://github.com/medic/chis-visualizations/tree/ETL
    2.	Create and insert data to source tables in Postgres as mentioned in source_data_creation.sql
    3.	Create target star schema tables and views in Postgres using the queries present in star_schema_tables_vw.sql.
    4.	Create meta data tables in Postgres as provided in metadata_details.sql 
    5.	Update the .dbenv file with the credentials of the data base on given environment.
    6.	Execute main.py to trigger the ETL.
 
B. Steps to update ETL/data model for new scenarios.

a. Scenario 1 - New column added in the source data follow the below steps.

    1. Add the source column details in the source_mapping_details along with it's transformation logic.
    2. If the source column is going to sit in an already existing table, then update the table to add the new column in postgres DB.
    3. Update the corresponding views along with fact_details_vw and semantic_layer_vw view updatation to accomodate new column.
    4. If the new column is required in a specific table which doesn't exist in the star schema then create the table in the star schema and follow the view updation.

b. Scenario 2 - If the new data requires any transformation which is not there in the existing tranformation rule then follow the below steps to add the logic in the ETL.

    1. Build new transformation logic in a factory class
    2. Register new factory class in transformer_factory.py with a new key.
    3. Configure the mapping table to have the columns that should undergo new transformation.

c. Scenario 3 - Add a new source follow the below steps.

    1. Add the source and target connection details in source_details metadata.
    2. Add the corresponding source and target table mapping in source_mapping_details metadata.
    3. If the source is not DB, then follow the steps described in scenario 2 to get a separate factory pattern for that source type.
    4. A separate factory pattern might be required if the data type is not JSON or the load type is other than Full load.

d. Scenario 4 - Updating views involving xform ids.

    1. As of now, we are getting the form_ids as a list with comma separated values (28fbbe5e-b54f-4cd8-a93f-d31d4a2e3344,adaab35c-0c4d-46bf-a439-ca321c0324b9)
    2. The feq_follow_up_vw view to get the count of form_id is being build based on comma separator ( array_length(regexp_split_to_array(form_id, ','),1), so if in the data there is any other separator than comma(,) then this view needs to be modified accordingly
    3. Example, if the separator is (;), then the above expression will be modified as (array_length(regexp_split_to_array(form_id, ';'),1)
    
e. Scenario 5 - Different schema for metadata tables.

    1. Update metadata_config.json to add the new schema name (now schema name is test_db) in source_details_schema_name variable and mapping_schema_name variable.
    2. If the metadata tables to be put in public schema then keep source_details_schema_name variable and mapping_schema_name variable as blank like the below one.
        {
            "source_details_schema_name" : "",
            "source_details_table_name" : "source_details",
            "mapping_schema_name" : "",
            "mapping_table_name" : "source_mapping_details"
        }

