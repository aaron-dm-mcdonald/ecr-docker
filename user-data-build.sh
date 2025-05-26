#!/bin/bash

# Install Docker
dnf update -y
dnf install -y docker

# Start Docker now and on reboot
systemctl enable --now docker

# Download Dockerfile
sudo mkdir -p /docker-src
sudo cd /docker-src
curl -O https://raw.githubusercontent.com/aaron-dm-mcdonald/ecr-docker/refs/heads/main/Dockerfile

# Authenticate and push to ECR as root
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${repo}

docker build -t my-app .
docker tag my-app:latest ${repo}:latest
docker push ${repo}:latest


