resource "aws_s3_bucket" "bucket_first_region" {
  bucket = lower("${var.namespace}-terraform-101-${var.region}")
}

resource "aws_s3_bucket" "bucket_second_region" {
  provider = aws.second_region
  bucket   = lower("${var.namespace}-terraform-101-${var.second_region}")
}