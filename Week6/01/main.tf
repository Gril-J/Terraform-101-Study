terraform {
  cloud {
    organization = "<name>"         # 생성한 ORG 이름 지정
    hostname     = "app.terraform.io"      # default
    workspaces {
      name = "terraform-aws-tfc"  
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
}

module "s3_bucket_module" {
  for_each = toset(var.bucket_name)
  source  = "app.terraform.io/gril/test/registry"
  version = "0.0.1"
  bucket_name = each.value
  ignore_policy = false
  public_policy = false
  block_acl = false
  restrict_public = false
}