FROM kiwenlau/serf-dnsmasq:0.1.0

MAINTAINER Amine BENELALLAM <amine.benelallam@inria.fr>

# install openssh-server, vim and openjdk
RUN apt-get install -y openssh-server vim
RUN apt-get install -y openjdk-7-jdk 

# move all configuration files into container
ADD files/* /root/  

# set jave environment variable 
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64 
ENV PATH $PATH:$JAVA_HOME/bin

#configure ssh free key access
RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
mv /usr/local/ssh_config ~/.ssh/config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


