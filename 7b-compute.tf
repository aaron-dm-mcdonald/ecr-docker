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
    command = file("${path.module}/scripts/wait-for-image.sh")
    interpreter = ["bash", "-c"]
    environment = {
      REPO_NAME = aws_ecr_repository.main.name
      REGION    = var.region
    }
  }
}

