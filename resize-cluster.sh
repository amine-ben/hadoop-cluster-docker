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
echo "" > files/slaves
echo "" > files/regionservers
i=1
while [ $i -lt $N ]
do
	echo "slave$i.mondo.com" >> files/slaves
	echo "slave$i.mondo.com" >> files/regionservers
	((i++))
done 


#build hbase-site.xml to update zookeepers

#rm hbase-site.xml 2>/dev/null

#hbase-site.xml.template contains all the needed options except for ZK property
cat files/hbase-site.xml.template > files/hbase-site.xml


# ZK is recommended to have odd number of instances (preferably 3 or 5)
# we decided to make it 3 if N is lt 10 and 5 otherwise

i=1
echo "master.mondo.com," >> files/hbase-site.xml
ZK=0
if [ $N -lt 10 ]
then
	ZK=3
else
	ZK=5
fi 
var1=""
while [ $i -lt $ZK ]
do
	((i++))
	var1=$var1"slave$i.mondo.com"
	if [ $i -lt $ZK ]
	then
	   var1=$var1"," 
	fi
done
echo $var1 >> files/hbase-site.xml
## create the footer of hbase-site.xml

echo -e "</value>\n\t</property>\n</configuration>" >> files/hbase-site.xml
# delete master container
sudo docker rm -f master 

# delete hadoop-master image
sudo docker rmi amineben/hadoop-master:$tag 

# rebuild hadoop-master image
pwd
sudo docker build -t amineben/hadoop-master:$tag .
