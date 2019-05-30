#!/usr/bin/env bash
# bash copy_hdfs_files.sh {hdfs agent ip address}
scp -i westncal.pem centos@$1:/etc/hadoop/conf/core-site.xml hdfs_conf
scp -i westncal.pem centos@$1:/etc/hadoop/conf/hadoop-env.sh hdfs_conf
scp -i westncal.pem centos@$1:/etc/hadoop/conf/hdfs-site.xml hdfs_conf
scp -i westncal.pem centos@$1:/etc/hadoop/conf/yarn-site.xml hdfs_conf

cp hdfs_conf/* /usr/local/Cellar/hadoop/3.1.2/libexec/etc/hadoop/