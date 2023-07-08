output "s3_bucket_name" {
  value       = aws_s3_bucket.backend_bucket.arn
  description = "S3 bucket ARN"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_backend.name
  description = "DynamoDB Table name"
}