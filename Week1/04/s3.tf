resource "aws_s3_bucket" "backend_bucket" {
  bucket = lower("${var.namespace}-terraform-backend")
}

resource "aws_s3_bucket_versioning" "backend_bucket" {
  bucket = aws_s3_bucket.backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

