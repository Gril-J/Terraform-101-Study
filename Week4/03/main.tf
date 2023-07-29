provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "gril-module-vpc"

  cidr = "100.10.0.0/16" 

  azs                 = var.azs
  private_subnets     = var.public_subnets
  public_subnets      = var.private_subnets

  create_database_subnet_group = false

  # DNS HOST, DHCP 활성화
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_dhcp_options  = true

  # NAT GATEWAY 활성화
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.vpc_tag

}