#!/bin/bash
jenkins_folder="/home/jenkins/jenkins_data"
jenkins_home="/home/jenkins"
jenkins_docker_id="1000"
username="jenkins"
uid="1001"

# create jenkins user and assign it to docker, wheel group
useradd $username
usermod -aG wheel $username
echo "password" | passwd --stdin $username
echo "$username ALL=(ALL:ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

# update and install java
yum update -y
yum install java-1.8.0 -y

# install docker, docker-compose and git
amazon-linux-extras install docker -y
systemctl start docker && sudo systemctl enable docker

curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker $username

yum install -y git

# Clone repo with Dockerfiles/Jenkinsfiles and make some folder and etc configuration
git clone https://github.com/ralimardanov/project_files.git $jenkins_home/project_files
mkdir -p $jenkins_home/jenkins_data/pipeline && mkdir -p $jenkins_home/jenkins_data/jenkins_home && mv $jenkins_home/project_files/* $jenkins_home/jenkins_data && rm -rf $jenkins_home/project_files
cd $jenkins_home/jenkins_data && mv java-app jenkins/ Jenkinsfile pipeline/ && rm -f README.md

sudo chown -R $uid:$uid $jenkins_folder && sudo chown -R $jenkins_docker_id:$jenkins_docker_id $jenkins_folder/jenkins_home && sudo chown $jenkins_docker_id:docker /var/run/docker.sock

# This will be used to save all config done on Jenkins server. Use 2 commented commands manually everytime you make some change on Jenkins server config and etc to have the latest backup.
#sudo tar -czvf jenkins.tar.gz jenkins_home/
#aws s3 cp jenkins.tar.gz s3://terraform-20201215213013426900000001/jenkins_config/
aws s3 cp s3://terraform-20201215213013426900000001/jenkins_config/jenkins.tar.gz .
sudo tar -xzvf jenkins.tar.gz jenkins_home/ && rm -rf jenkins.tar.gz

docker-compose build
docker-compose up -d
newgrp docker