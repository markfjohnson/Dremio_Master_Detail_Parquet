#!/usr/bin/env bash
# This script removes the temporary parquet file and clears out the s3 bucket
rm -rf master-detail-gzip.parquet
aws s3 rm s3://dremio-dwn --recursive