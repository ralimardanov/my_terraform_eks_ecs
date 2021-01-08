#!/bin/bash
jenkins_path='/home/jenkins/jenkins-data'

# create jenkins user and assign it to docker, wheel group
sudo -i
useradd jenkins
usermod -aG wheel jenkins
echo "password" | passwd --stdin jenkins
echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

# update and install java
yum update -y
yum install java-1.8.0 -y

# install docker, docker-compose and git
amazon-linux-extras install docker -y
systemctl start docker && sudo systemctl enable docker

curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker jenkins

yum install -y git

# jenkins config
su - jenkins
mkdir -p /home/jenkins/jenkins-data/jenkins_home && cd /home/jenkins/jenkins-data
cat > docker-compose.yml <<EOF
version: '3'
services:
  jenkins:
    container_name: jenkins
    image: jenkins/jenkins
    ports:
      - "8080:8080"
    volumes:
      - $PWD/jenkins_home:/var/jenkins_home
    networks:
      - net
networks:
  net:
EOF
sudo chown 1001:1001 -R $jenkins_path && sudo chown -R 1000:1000 $jenkins_path/jenkins_home
# This will be used to save all config done on Jenkins server. Use 2 commented commands manually everytime you make some change on Jenkins server config and etc to have the latest backup.

#sudo tar -czvf jenkins.tar.gz jenkins_home/
#aws s3 cp jenkins.tar.gz s3://terraform-20201215213013426900000001/jenkins_config/
#sudo rm -rf jenkins_home/*
aws s3 cp s3://terraform-20201215213013426900000001/jenkins_config/jenkins.tar.gz .
sudo tar -xzvf jenkins.tar.gz jenkins_home/ && rm -rf jenkins.tar.gz
docker-compose up -d
newgrp docker