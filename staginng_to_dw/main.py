#!/usr/bin/python
import psycopg2
from config import config
import helper
import pandas as pd
import json


def fetch_metadata():
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        params = config()
        # read metadata config file to get the schema name and table names of the metadata config
        metadata_file = open('/usr/local/airflow/app/metadata_config.json', "r")
        metadata = json.loads(metadata_file.read())
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)

        # create a cursor
        cur = conn.cursor()
        # Iterating through the json
        # list
        if metadata['source_details_schema_name'] == "":
            source_details_query = "select * from " + metadata['source_details_table_name'] + " where processing_needed = 'yes' "
        else:
            source_details_query = "select * from " + metadata['source_details_schema_name']+"."+metadata['source_details_table_name'] + " where processing_needed = 'yes' "
        print('source_details_query', source_details_query)

        cur.execute(source_details_query)
        metadata_details_data = cur.fetchall()

        column_name = [entry.name for entry in cur.description]

        metadata_mapping_details = []
        for data in metadata_details_data:
            print('processing for run id',str(data[0]))
            if metadata['mapping_schema_name'] == "":
                mapping_details_query = "select * from " + metadata['mapping_table_name'] + " where run_id = "+str(data[0])
            else:
                mapping_details_query = "select * from " + metadata['mapping_schema_name'] + "." + metadata['mapping_table_name'] + " where run_id = "+str(data[0])
            print('mapping_details_query',mapping_details_query)
            cur.execute(mapping_details_query)
            for entry in cur.fetchall():
                metadata_mapping_details.append(list(entry))

        mapping_column = [entry.name for entry in cur.description]
        # close the communication with the PostgreSQL
        cur.close()

        return pd.DataFrame(data=metadata_details_data, columns=column_name), \
               pd.DataFrame(data=metadata_mapping_details, columns=mapping_column)
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')


if __name__ == '__main__':
    try:
        metadata_df, metadata_mapping_df = fetch_metadata()
        # print(metadata_to_process)
        helper.process_data(metadata_df, metadata_mapping_df)
    except Exception as e:
        print(f"Failed to read metadata with exception: {e}")
        exit(1)
