variable "aws_region" {
  default = "us-east-1"
}

variable "lamda_source_file" {
  default = "greet_lambda.py"
}
variable "lambda_function_name" {
  default = "greet_lambda"
}

variable "lambda_output_path" {
  default = "output.zip"
}

variable "lamda_runtime" {
  default = "python3.9"
}
variable "function_role" {
  default = "function-role"
}
