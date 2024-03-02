# used iam role to get current account id
data "aws_caller_identity" "current" {}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/lambda-hello-world-python.zip"
}

locals {
  lambda_hw_fname = "tflabs-helloworld-iac"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python/lambda-hello-world-python.zip"
  function_name = local.lambda_hw_fname
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda-hello-world.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}
