provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "grilsbucket" {
  bucket = lower("${var.namespace}-t101study-tfstate")
}

# Enable versioning so you can see the full revision history of your state files
resource "aws_s3_bucket_versioning" "grilbucket_versioning" {
  bucket = aws_s3_bucket.grilsbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.grilsbucket.arn
  description = "The ARN of the S3 bucket"
}

resource "aws_dynamodb_table" "grildynamodbtable" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.grildynamodbtable.name
  description = "The name of the DynamoDB table"
}