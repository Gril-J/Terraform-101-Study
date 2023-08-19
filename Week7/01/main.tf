terraform {
  cloud {
    organization = "gril"         # 생성한 ORG 이름 지정
    hostname     = "app.terraform.io"      # default
    workspaces {
      name = "terraform-github-actions"  
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
}

module "github_module_s3t" {
  for_each = toset(var.bucket_name)
  source = "github.com/Gril-J/Terraform-101-Study/Week4/02/modules/s3_public" 
  bucket_name = each.value
  ignore_policy = false
  public_policy = false
  block_acl = false
  restrict_public = false
}
