#!/bin/bash

if [ $# = 0 ]
then
	echo "Please use the node number of the cluster as the argument!"
	exit 1
fi

tag="latest"

# N is the node number of the cluster
N=$1

cd hadoop-master

# change the slaves file
echo "master.mondo.com" > files/slaves
i=1
while [ $i -lt $N ]
do
	echo "slave$i.mondo.com" >> files/slaves
	((i++))
done 

# delete master container
sudo docker rm -f master 

# delete hadoop-master image
sudo docker rmi amineben/hadoop-master:$tag 

# rebuild hadoop-master image
pwd
sudo docker build -t amineben/hadoop-master:$tag .
