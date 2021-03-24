import psycopg2
import json
from io import StringIO


class Postgresql:
    def __call__(self, connection_details, table_name, data, load_type, **kwargs):
        self.connection_details = json.loads(connection_details)
        self.table_name = table_name
        self.data = data
        self.load_type = load_type
        self.additional_data_dict = kwargs
        return self

    def load_data(self):
        conn = psycopg2.connect(**self.connection_details)
        # save dataframe to an in memory buffer
        buffer = StringIO()
        self.data.to_csv(buffer, index=False, header=False,sep="\t")
        buffer.seek(0)
        cursor = conn.cursor()
        try:
            cursor.copy_from(buffer, self.table_name, sep="\t")
            conn.commit()
        except (Exception, psycopg2.DatabaseError) as error:
            print("Error: %s" % error)
            conn.rollback()
            cursor.close()
            return 1

        cursor.close()




