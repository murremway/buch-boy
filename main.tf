provider "aws" {
  region  = "us-east-1"
}

resource "aws_vpc" "devops" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Devops"
  }
}

resource "aws_subnet" "devops_public_subnet" {
  vpc_id            = aws_vpc.devops.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Devops Public Subnet"
  }
}

resource "aws_subnet" "devops_private_subnet" {
  vpc_id            = aws_vpc.devops.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "devops Private Subnet"
  }
}

resource "aws_internet_gateway" "devops_ig" {
  vpc_id = aws_vpc.devops.id

  tags = {
    Name = "devops Internet Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.devops_ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.devops_public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}