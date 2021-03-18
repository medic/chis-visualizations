# from datetime import date, timedelta
import psycopg2
import json
from datetime import datetime


class ReadPostgresql:
    def __call__(self, connection_details, table_name, column_details, load_type, **kwargs):
        self.connection_details = json.loads(connection_details)
        self.table_name = table_name
        self.column_details = column_details
        self.check_column_name = kwargs["check_column_name"]
        self.check_column_value = kwargs["check_column_value"]
        self.load_type = load_type
        self.load_date = kwargs["increment_date"]
        self.additional_data_dict = kwargs
        return self

    def get_data(self):
        conn = psycopg2.connect(**self.connection_details)
        cursor = conn.cursor()
        try:
            if self.load_type.lower() == 'full':
                query = "select " + self.column_details + " from " + self.table_name
            elif self.load_type.lower() == 'incremental':
                if self.load_date:
                    query = "select " + self.column_details + " from " + self.table_name + " where insert_date = '" + str(self.load_date) + "'"

                else:
                    query = "select " + self.column_details + " from " + self.table_name + "where insert_date = (" \
                                                                                           "select(max(insert_date)) " \
                                                                                           "from  "+ \
                            self.table_name+") "

            cursor.execute(query)

        except (Exception, psycopg2.DatabaseError) as error:
            print("Error: %s" % error)
            cursor.close()
            return 1

        # Naturally we get a list of tupples
        source_data = cursor.fetchall()
        cursor.close()

        return source_data
