terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "s3_bucket_module" {
  for_each = toset(var.bucket_name)
  source = "./modules/s3_public" 
  bucket_name = each.value
  ignore_policy = false
  public_policy = false
  block_acl = false
  restrict_public = false
}