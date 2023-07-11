resource "aws_vpc" "grilvpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.namespace}study"
  }
}

resource "aws_subnet" "grilsubnet1" {
  vpc_id     = aws_vpc.grilvpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "${var.namespace}subnet1"
  }
}

resource "aws_subnet" "grilsubnet2" {
  vpc_id     = aws_vpc.grilvpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = data.aws_availability_zones.azs.names[2]

  tags = {
    Name = "${var.namespace}subnet2"
  }
}

resource "aws_internet_gateway" "griligw" {
  vpc_id = aws_vpc.grilvpc.id

  tags = {
    Name = "${var.namespace}-igw"
  }
}

resource "aws_route_table" "grilrt" {
  vpc_id = aws_vpc.grilvpc.id

  tags = {
    Name = "${var.namespace}-rt"
  }
}

resource "aws_route_table_association" "grilrtassociation1" {
  subnet_id      = aws_subnet.grilsubnet1.id
  route_table_id = aws_route_table.grilrt.id
}

resource "aws_route_table_association" "grilrtassociation2" {
  subnet_id      = aws_subnet.grilsubnet2.id
  route_table_id = aws_route_table.grilrt.id
}

resource "aws_route" "grildefaultroute" {
  route_table_id         = aws_route_table.grilrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.griligw.id
}

