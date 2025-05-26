output "ecr_repo_address" {
  value = aws_ecr_repository.main.repository_url
}

output "ami_info" {
  value = {
    arn         = data.aws_ami.ami.arn
    id          = data.aws_ami.ami.id
    description = data.aws_ami.ami.description
  }
}

output "ec2_info" {
  value = {
    public_ip  = aws_instance.docker.public_ip
    public_dns = "http://${aws_instance.docker.public_dns}"
  }
}

output "api_gateway_url" {
  description = "Invoke URL for lambda"
  value       = aws_lambda_function_url.hello_world.function_url
}


