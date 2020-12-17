#!/bin/bash

# update and install java
sudo yum update -y
sudo yum install java-1.8.0 -y

# install docker, docker-compose and git
sudo amazon-linux-extras install docker -y
sudo usermod -aG docker $USER 
sudo systemctl start docker && sudo systemctl enable docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo yum install -y git

# create jenkins user and assign it to docker, wheel group
sudo -i
useradd jenkins
echo "password" | passwd --stdin jenkins
usermod -aG wheel jenkins
usermod -aG docker jenkins
echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
