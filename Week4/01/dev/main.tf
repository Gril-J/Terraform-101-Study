resource "aws_vpc" "dev_grilvpc" {
  cidr_block       = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "dev_t101-study"
  }
}

resource "aws_subnet" "dev_grilsubnet1" {
  vpc_id     = aws_vpc.dev_grilvpc.id
  cidr_block = "10.20.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "dev_t101-subnet1"
  }
}

resource "aws_subnet" "dev_grilsubnet2" {
  vpc_id     = aws_vpc.dev_grilvpc.id
  cidr_block = "10.20.2.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "dev_t101-subnet2"
  }
}