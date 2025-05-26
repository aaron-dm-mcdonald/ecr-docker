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
  force_delete = true
}

