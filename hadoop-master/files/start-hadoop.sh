#!/bin/bash
echo -e "\nStarting hdfs"
$HADOOP_INSTALL/sbin/start-dfs.sh

echo -e echo -e "\nStarting yarn"
$HADOOP_INSTALL/sbin/start-yarn.sh

echo -e echo -e "\nStarting jobHistory Server"
