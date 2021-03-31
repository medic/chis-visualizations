# from datetime import date, timedelta
import psycopg2
import pandas as pd
import json

class Copy:
    def __call__(self, data,transformation_details, **kwargs):
        self.data = data
        self.transformation_details = transformation_details
        self.target_column_details = kwargs['target_column_details']
        self.additional_data_dict = kwargs
        return self

    def get_transformed_data(self):
        return self.data


class TransformColumnToRow:
    def __call__(self, data, transformation_details, **kwargs):
        self.data = data
        self.transformation_details = transformation_details
        self.target_column_details = kwargs['target_column_details']
        self.additional_data_dict = kwargs
        return self

    def get_transformed_data(self):

        target_column_details = json.loads(self.target_column_details)
        target_df = pd.DataFrame()
        for target_column in target_column_details:
            if target_column_details[target_column] == "transformed_column_name":
                target_df[target_column] = [self.transformation_details['column_to_transform']] * len(self.data)
            else:
                dummy=target_column_details[target_column]
                target_df[target_column] = self.data[target_column_details[target_column]]

        target_df
        return target_df