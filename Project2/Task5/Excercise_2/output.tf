output "lambda_function_arn" {
  value = "${aws_lambda_function.geeting_lambda.arn}"
}

output "log_group_arn" {
  value       = join("", aws_cloudwatch_log_group.function_log_group.*.arn)
  description = "ARN of the log group"
}

output "log_group_name" {
  description = "Name of log group"
  value       = join("", aws_cloudwatch_log_group.function_log_group.*.name)
}
