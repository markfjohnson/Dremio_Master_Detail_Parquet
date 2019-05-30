# Create a Master Detail Nested Parquet File

**NOTE:** This program is provided as an example of how to create a master detail relationship within a Parquet table based on two source tables using Dremio.  This program does not address a specific a production requirement nor is any part of this specific part of Dremio's support offerings.
## Requirements
* Access to a Hadoop cluster
* hdfs client on the machine where this process will run
* Python 2.7
* Installed Dremio Enterprise 3.1.9 or higher

## Out of scope
The following tasks are left for future explorations and are out of scope for this example:
* Kerberos interface
* Datasets master-detail relationships beyond that setup in this example
* Referencing source files from a space other than those specified in this document.
* The home directory will contain the input files, the 'HR_Reporting' space will hold the output.  The program can be extended to support multiple spaces, but in the interest of time it has been constrained to just 1 each.
* Adding more than 1 master_detail reporting file.  This approach will work off the "Full Refresh" strategy.


## Setting up the enviorment for this example
* Create the 'HR' and 'Reporting' required Dremio spaces
* Upload the Department and Employee files into the Dremio Cluster
* Add the users 'hr_admin' and 'hr_reporting' to the Dremio cluster
* Specify the HDFS Path to hold the output reporting file in the parameters section of the sample program

## Sample Application
This sample of how to create a Master Detail relationship without performing a JOIN Pulls the Department and Employee Datasets from the 'HR' space and inserts All of the Employee records for a given department into a Designated Struct Array column on the Department file.

## Step 1: Setting the properties to run the program

1. Ensure the parameters section variables are specified as described below:

| Field        | Value       |
|--------------|-------------|
| out_space    | @mark |
| master_file  | Department  |
| detail_file  | Employee    |
| master_detail| dept_emp
| HDFS_reporting_path | {user specified HDFS reporting directory (i.e. /hr_reporting} |

2. Copy the files hadoop-env.sh, core-site.xml, hdfs-site.xml, yarn-site.xml from the Hadoop clusters /etc/hadoop/conf directory into this project directories hdfs_conf directory.  Failure to copy the latest versions of thes HDFS client files will cause the hdfs put of the master-detail reporting file to not get placed up into hdfs. 
2. Make the HDFS HR reporting directory if it does not already exist
```
hdfs dfs -mkdir -p /hr_reporting
```

 

## Step 2: Running the Program
1. Modify the parameters section of the sample program and assign the variable 'HDFS_reporting_path' with the path specified in Step 1.1.

    XXX Include screen print here 

2. Run the program
```
python join_master_detail
```
The steps taken by the ```join_master_detail``` program are enumerated below:
   * Opens JDBC connection and reads table as a Spark Dataframe
   * Loops through the department dataframe
      * Selects all employee rows with the department ID as a Spark Dataframe
      * Loop through the employee dataframe and build a dict array object with each array element as an individual employee.
      * update the department emp-detail column with the dict array object
   *  save the modified department dataframe to the local directory in a file name specified by the variable master_detail
   * HDFS put the newly created master_detail Parquet file into the HR_Reporting_path
   * Create master_detail data source using the HDFS connector
   * (Optional) Create reflections for the newly created master detail table
    
## Step 3: Performing queries from the HR Master-Detail dataset  
   XXX Execute a Dremio GUI SQL query on the Master-Detail file

## References:
* Setting up the [HDFS client on MacOS](https://community.hortonworks.com/articles/75253/connect-hadoop-client-on-mac-os-x-to-kerberized-hd.html)