#!/bin/bash
rocky_docker(){
#remove old docker, just in case it's there. So we start fresh. 
sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc

sudo dnf -y install dnf-plugins-core -y

sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
#enable docker to start on boot, and also to start it now. 
sudo systemctl enable --now docker


#create the folder where I store my apps and services. 
sudo mkdir -p /opt/docker/
}