#!/bin/bash

dnf update -y
dnf install -y docker git
systemctl enable --now docker
sudo mkdir -p /docker-src
cd /docker-src
sudo git clone https://github.com/aaron-dm-mcdonald/ecr-docker.git .
cd /docker-src/src
docker build -t my-app .