import psycopg2

from factory import data_source_factory as dsf
from factory import data_format_factory as dataformatter
from factory import transformation_factory as transformer
from factory import target_factory as tf
import pandas as pd
import json
import datetime
from config import config


def load_data_to_database(data,
                          table_name,
                          target_type,
                          connection_details,
                          load_type):
    """

    :param data:
    :param table_name:
    :param target_db:
    :param target_connection_details:
    :param load_type:
    :return:
    """

    target_processor = tf.target_factory.create(target_type,
                                                connection_details=connection_details,
                                                table_name=table_name,
                                                data=data,
                                                load_type=load_type)
    target_processor.load_data()


def process_source_n_load_target(source_df,
                                 metadata_mapping_df,
                                 target_db,
                                 target_db_connection_details,
                                 load_type):
    """

    :param source_df:
    :param metadata_mapping_df:
    :param target_db:
    :param target_db_connection_details:
    :param load_type:
    :return:
    """

    # below for loop to process individual table data.
    current_timestamp = datetime.datetime.now()
    for current_target_table in metadata_mapping_df["target_table"].unique():
        print(f'Processing target table:{current_target_table}')
        data_frame_dict = {}
        current_mapping_data = metadata_mapping_df[metadata_mapping_df["target_table"] == current_target_table]
        # Populate default values in source Dataframe.
        list_of_source_columns = current_mapping_data['source_column'].tolist()
        for source_column in list_of_source_columns:
            if source_column not in source_df.columns.tolist():
                source_df[source_column] = \
                    current_mapping_data[current_mapping_data['source_column'] == source_column][
                        'default_value'].tolist()[0]

        # Below for loop processes individual column data
        # outputs a dictionary with target_column_name as key and transformed data as value.
        for index, current_record in current_mapping_data.iterrows():
            transformation_details = json.loads(current_record["transformation_rule"])
            if len(list(current_record["source_column"].split(","))) > 1:
                data = source_df[list(current_record["source_column"].split(","))]
            else:
                data = source_df[current_record["source_column"]]
            transform = transformer.transformer_factory.create(
                transformation_details['rule'],
                data=data,
                transformation_details=transformation_details,
                target_column_details=current_record['target_column']
            )

            if transformation_details['rule'] in ['copy']:
                data_frame_dict[current_record["target_column"]] = transform.get_transformed_data()

            elif transformation_details['rule'] == 'transpose_column_name_to_row':
                target_df = transform.get_transformed_data()
                target_df["insert_timestamp"] = current_timestamp
                target_df["update_timestamp"] = current_timestamp
                load_data_to_database(data=target_df,
                                      table_name=current_target_table,
                                      target_type=target_db,
                                      connection_details=target_db_connection_details,
                                      load_type=load_type)

        if transformation_details['rule'] in ['copy']:
            target_df = pd.DataFrame(data_frame_dict)
            target_df["insert_timestamp"] = current_timestamp
            target_df["update_timestamp"] = current_timestamp

            load_data_to_database(data=target_df,
                                  table_name=current_target_table,
                                  target_type=target_db,
                                  connection_details=target_db_connection_details,
                                  load_type=load_type)


def process_data(metadata_df, metadata_mapping_df):
    # loop through the list of src to be processed
    for index, current_source in metadata_df.iterrows():
        try:
            print(f'Reading data for source:{current_source["source_name"]}')
            data_source = dsf.data_source_factory.create(current_source["source_type"],
                                                         connection_details=current_source["source_connection_details"],
                                                         table_name=current_source["source_name"],
                                                         column_details=current_source["source_column_details"],
                                                         check_column_name="run_id",
                                                         check_column_value=current_source["run_id"],
                                                         load_type=current_source["load_type"],
                                                         increment_date=current_source["load_date"]
                                                         )
            response = data_source.get_data()
            try:
                source_df = load_response_to_dataframe(response, data_format=current_source["data_format"])
                try:
                    process_source_n_load_target(source_df,
                                                 metadata_mapping_df[
                                                     metadata_mapping_df["source_table"] == current_source[
                                                         "source_name"]],
                                                 current_source["target_db_name"],
                                                 current_source["target_db_connection_details"],
                                                 current_source["load_type"]
                                                 )
                except Exception as e:
                    source_name = current_source["source_name"]
                    target_table = current_source["target_db_name"]
                    print(f"Failed to load data from source :{source_name} to target: {target_table},"
                          f" with error:{e}")
            except Exception as e:
                source_name = current_source["source_name"]
                data_format = current_source["data_format"]
                target_table = current_source["target_db_name"]
                print(f"Failed to read load data to dataframe for source:{source_name} with target: {target_table},"
                      f" with error:{e}")
        except Exception as e:
            source_name = current_source["source_name"]
            target_table = current_source["target_db_name"]
            print(f"Failed to read load data to dataframe for source:{source_name} for target: {target_table},"
                  f" with error:{e}")


def load_response_to_dataframe(response, data_format):
    data_loader = dataformatter.data_formatter_factory.create(
        data_format,
        data=response)
    source_df = data_loader.load_to_dataframe()
    return source_df
    # read data from src --factory (postgres)
    # for each src read the mapping table
