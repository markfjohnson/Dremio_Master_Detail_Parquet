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
* Using anything other than a S3 datasource


## Setting up the environment for this example
* Create the master-detail S3 data source.  Make certain you have the bucket dremio-dwn or modify the program accordingly.
* Make certain the Department and Employee files are loaded into the myspace space of the Dremio Cluster
* Specify the S3 bucket to hold the output reporting file in the parameters section of the sample program

## Sample Application
This sample of how to create a Master Detail relationship without performing a JOIN Pulls the Department and Employee Datasets from the 'HR' space and inserts All of the Employee records for a given department into a Designated Struct Array column on the Department file.

## Step 1: Setting the properties to run the program

*. Ensure the parameters section variables at the top of the join_master_detail.py are properly specified.

 

## Step 2: Running the Program
1. Modify the parameters section of the sample program and assign the variable 'HDFS_reporting_path' with the path specified in Step 1.1.

2. Run the program
```
python join_master_detail
```
    
## Step 3: Performing queries from the HR Master-Detail dataset  
* Go to the Sources section and select 'master-detail', then select 'dremio-dwn' which should have a purple icon if the program was successful.
* execute a query
