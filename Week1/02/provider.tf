terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3"
    }
  }
  backend "s3" {
  bucket         = "gril-terraform-backend"
  key            = "test/terraform.tfstate"
  region         = "ap-northeast-2"
  dynamodb_table = "Gril-terraform-backend"
  }
}

provider "aws" {
  region = var.region
}