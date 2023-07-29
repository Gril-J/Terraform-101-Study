terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_s3_bucket" "gril_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownershop" {
  bucket = aws_s3_bucket.gril_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.gril_bucket.id
  policy = data.aws_iam_policy_document.public_s3_policy.json
}
data "aws_iam_policy_document" "public_s3_policy" {
  statement {
    sid      = "1"
    effect    = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.gril_bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
resource "aws_s3_bucket_public_access_block" "gril_bucket_public" {
  bucket = aws_s3_bucket.gril_bucket.id
  block_public_acls   = var.block_acl
  block_public_policy = var.public_policy
  ignore_public_acls      = var.ignore_policy
  restrict_public_buckets = var.restrict_public
}