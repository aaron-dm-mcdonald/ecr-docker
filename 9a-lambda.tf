resource "aws_lambda_function" "hello_world" {
  function_name = "hello-world-lambda"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.main.repository_url}:latest"

  role = aws_iam_role.lambda_exec_role.arn

  # Optional: Timeout defaults to 3 seconds; you can increase up to 900 (15 minutes)
  timeout = 30

  depends_on = [ aws_instance.docker, aws_instance.docker,null_resource.wait_for_image ]

}

resource "aws_lambda_function_url" "hello_world" {
  function_name      = aws_lambda_function.hello_world.function_name
  authorization_type = "NONE"
}