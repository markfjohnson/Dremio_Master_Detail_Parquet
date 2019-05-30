import requests
import json
from pyspark import SparkConf
from pyspark.sql import SparkSession
from pyspark.sql.types import *


## Program parameters
user_name = "mark"
password = "dremio_jpmc"
dremio_coord_host = "localhost"

# Define Master source table
master_table = "myspace.Department"
master_fld_id = "dept_id"
master_nested_fld = "emp_detail"

# Define the Detail Table
detail_table = "myspace.Employees"
detail_fld_id = "dept_id"

#Define the master-detail output file
master_detail_filename = "master-detail-gzip.parquet"


# Define the Master-detail output schema
master_detail_schema = StructType([
    StructField('dept_id', StringType()),
    StructField('dept_name', StringType()),
    StructField('emp_detail', ArrayType(
        StructType([
            StructField("emp_id", StringType()),
            StructField("dept_id", StringType()),
            StructField("name", StringType()),
            StructField("hire_date", StringType())
        ])
    ))])

jar_path = "lib/dremio-jdbc-driver-3.2.2-201905231753430810-ccf9a4e.jar"
conf = SparkConf().set("spark.jars", jar_path)
spark = SparkSession.builder.appName('Master Detail Join example program').config(conf=conf).getOrCreate()
jdbcurl = "jdbc:dremio:direct={}:31010".format(dremio_coord_host)


def login_dremio(user, passwd, server_url):
    header_values = {
        "content-type": "application/json"
    }

    user_info = {
        'userName': user,
        'password': passwd

    }

    token = "**"
    login_url = "{}:9047/apiv2/login".format(server_url)
    print(login_url)
    resp = requests.post(login_url, data=json.dumps(user_info), headers=header_values)
    if resp.status_code == 200:
        token = "_dremio{}".format(json.loads(resp.content)['token'])
        print("Token", token)
    else:
        print(resp)
    return (token)


def get_table_df(user, passwd, table_name):
    jdbc_properties = {
        "driver": "com.dremio.jdbc.Driver",
        "user": user,
        "password": passwd,
        "ENGINE": "dremio"
    }

    df = spark.read.jdbc(url=jdbcurl, table=table_name, properties=jdbc_properties)
    return df.toPandas()


def create_master_detail(df_master, master_id_fld, df_detail, detail_id_field):
    emp_dict_list = []
    for i, row in df_master.iterrows():
        emp_dict = get_detail_rows(row, master_id_fld, df_detail, detail_id_field)
        emp_dict_list.append(emp_dict)

    df_master[master_nested_fld] = emp_dict_list
    return (df_master)


def get_detail_rows(row, master_fld_id, df_detail, detail_fld_id):
    a = df_detail[df_detail[detail_fld_id] == row[master_fld_id]]
    return (a.to_dict('records'))


def main():
    spark.sparkContext.setLogLevel("WARN")
    print("Beginning Master Detail creation process")
    df_master = get_table_df("mark", "dremio123", master_table)
    df_detail = get_table_df("mark", "dremio123", detail_table)
    df_master_detail = create_master_detail(df_master, master_fld_id, df_detail, detail_fld_id)
    df_final = spark.createDataFrame(df_master_detail, schema=master_detail_schema)
    df_final.write.parquet(master_detail_filename)
    print("Created a Master detail output file {} and stored in the local directory".format(master_detail_filename))
    #
    # Now push the created Master Detail Parquet file to S3 Bucket
    # Then update the master-detail source with the new file


if __name__ == "__main__":
    main()
