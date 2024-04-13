provider "aws" {
  region = var.region
}

resource "aws_vpc" "kaizen" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.public_subnets[0].cidr
  availability_zone = var.public_subnets[0].availability_zone
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.public_subnets[1].cidr
  availability_zone = var.public_subnets[1].availability_zone
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.private_subnets[0].cidr
  availability_zone = var.private_subnets[0].availability_zone
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.private_subnets[1].cidr
  availability_zone = var.private_subnets[1].availability_zone
}

resource "aws_internet_gateway" "homework5_igw" {
  vpc_id = aws_vpc.kaizen.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.homework5_igw.id
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.kaizen.id
}

resource "aws_route_table_association" "public1_association" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_association" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private1_association" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2_association" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "allow_ports" {
  name        = "allow_ports"
  description = "Allow inbound traffic on specified ports"

    ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ubuntu" {
  count         = 1
  ami           = var.ec2_types[0].ami_id
  instance_type = var.ec2_types[0].instance_type
  subnet_id     = aws_subnet.public1.id
  security_groups = [aws_security_group.allow_ports.name]

  tags = {
    Name = var.ec2_types[0].name
  }
}

resource "aws_instance" "amazon" {
  count         = 1
  ami           = var.ec2_types[1].ami_id
  instance_type = var.ec2_types[1].instance_type
  subnet_id     = aws_subnet.public2.id
  security_groups = [aws_security_group.allow_ports.name]

  tags = {
    Name = var.ec2_types[1].name
  }
}
