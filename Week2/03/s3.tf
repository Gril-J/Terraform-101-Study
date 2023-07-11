variable "region" {
  type = string
  description = "aws region"
  default     = "ap-northeast-2"
}

variable "namespace" {
  type = string
  default = "Gril"
}

variable "s3name" {
  type = string
  default = "terraform-bucket"
}

# namespace와 s3name을 참조하여 소문자로 bucket name을 생성
resource "aws_s3_bucket" "var_bucket" {
  bucket = lower("${var.namespace}-${var.s3name}")
}

resource "aws_s3_bucket_versioning" "var_bucket" {
  bucket = aws_s3_bucket.var_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

