#!/bin/bash

echo "Waiting for 60s for EC2 image builder initalization before checking..."
sleep 60

for i in $(seq 1 12); do
  echo "Checking for ECR image: attempt $i"
  if aws ecr describe-images --repository-name ${REPO_NAME} --image-ids imageTag=latest --region ${REGION} >/dev/null 2>&1; then
    echo "ECR image found!"
    exit 0
  fi
  echo "Image not found yet, waiting 20 seconds..."
  sleep 20
done

echo "Timeout reached: ECR image not found"
exit 1
