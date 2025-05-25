resource "aws_ecr_repository" "main" {
  name                 = "test3"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name = "test 3"
    env  = "dev"
  }
}

output "ECR_address" {
  value = aws_ecr_repository.main.repository_url
}