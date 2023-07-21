terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "aws" {
  alias = "second_region"
  region = var.second_region
}