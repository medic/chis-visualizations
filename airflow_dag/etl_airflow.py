from airflow import DAG
from airflow.operators import BashOperator,PythonOperator
from datetime import datetime, timedelta

one_day_ago = datetime.combine(datetime.today() - timedelta(1),
                                      datetime.min.time())

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': one_day_ago,
    'email': [''],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
  }

dag = DAG('etl_pipeline', default_args=default_args)

t1 = BashOperator(
    task_id='load_to_data_warehouse',
    bash_command='python /usr/local/airflow/app/main.py',
    dag=dag)