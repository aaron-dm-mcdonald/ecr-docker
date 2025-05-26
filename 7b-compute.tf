resource "aws_instance" "docker" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.docker.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ecr_access.name

  user_data = templatefile("${path.module}/scripts/user-data-build-server.sh", {
    region = var.region,
    repo   = aws_ecr_repository.main.repository_url
  })

  tags = {
    Name = "docker-builder"
  }
  depends_on = [aws_ecr_repository.main]
}

resource "null_resource" "wait_for_image" {
  depends_on = [aws_instance.docker]

  provisioner "local-exec" {
    command = <<EOT
for i in $(seq 1 24); do
  echo "Checking for ECR image: attempt $i"
  if aws ecr describe-images --repository-name ${aws_ecr_repository.main.name} --image-ids imageTag=latest --region ${var.region} >/dev/null 2>&1; then
    echo "ECR image found!"
    exit 0
  fi
  echo "Image not found yet, waiting 10 seconds..."
  sleep 10
done
echo "Timeout reached: ECR image not found"
exit 1
EOT

    interpreter = ["bash", "-c"]
  }
}
