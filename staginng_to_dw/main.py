#!/usr/bin/python
import psycopg2
from config import config
import helper
import pandas as pd


def fetch_metadata():
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        params = config()

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)

        # create a cursor
        cur = conn.cursor()

        # execute a statement
        cur.execute("SELECT * from test_db.source_details where processing_needed = 'yes'")

        # display the PostgreSQL database server version
        metadata_details = cur.fetchall()

        column_name = [entry.name for entry in cur.description]

        metadata_mapping_details = []
        for run_id in metadata_details:
            cur.execute("SELECT * from test_db.source_mapping_details where run_id = run_id")
            for entry in cur.fetchall():
                metadata_mapping_details.append(list(entry))

        mapping_column = [entry.name for entry in cur.description]
        # close the communication with the PostgreSQL
        cur.close()

        return pd.DataFrame(data=metadata_details, columns=column_name), \
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
