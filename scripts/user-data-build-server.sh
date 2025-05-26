#!/bin/bash

# Install Docker
dnf update -y
dnf install -y docker git

# Start Docker now and on reboot
systemctl enable --now docker

# Clone the repo and cd into src folder
sudo rm -rf /docker-src
sudo git clone https://github.com/aaron-dm-mcdonald/ecr-docker.git /docker-src
sudo cd /docker-src/src

# Authenticate to ECR
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${repo}

# Build, tag, and push the image
sudo docker build -t my-app .
sudo docker tag my-app:latest ${repo}:latest
sudo docker push ${repo}:latest

