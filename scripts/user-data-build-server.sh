#!/bin/bash

# Install Docker
dnf update -y
dnf install -y docker git

# Start Docker now and on reboot
systemctl enable --now docker

# Download Dockerfile/app
sudo mkdir -p /docker-src
cd /docker-src
sudo git clone https://github.com/aaron-dm-mcdonald/ecr-docker.git .
cd /docker-src/src

# Authenticate to ECR
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${repo}

# Build, tag, and push the image
sudo docker build -t my-app .
sudo docker tag my-app:latest ${repo}:latest
sudo docker push ${repo}:latest

