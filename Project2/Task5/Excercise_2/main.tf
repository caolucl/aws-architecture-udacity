provider "aws" {
  region = var.aws_region
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.geeting_lambda.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_role" "function_role" {
  name               = var.function_role
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal : {
          "Service" : "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "function_logging_policy" {
  name   = "function-logging-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role = aws_iam_role.function_role.id
  policy_arn = aws_iam_policy.function_logging_policy.arn
}

data "archive_file" "lambda_file_zip" {
    type = "zip"
    source_file = var.lamda_source_file
    output_path = var.lambda_output_path
}

# Lambda function
resource "aws_lambda_function" "geeting_lambda" {
  function_name = var.lambda_function_name
  filename = data.archive_file.lambda_file_zip.output_path
  source_code_hash = data.archive_file.lambda_file_zip.output_base64sha256
  handler = "greet_lambda.lambda_handler"
  runtime = var.lamda_runtime
  role = aws_iam_role.function_role.arn
  environment{
      variables = {
          greeting = "Default value"
      }
  }
}
