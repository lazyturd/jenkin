# VPC BLOCK

# creating VPC
resource "aws_vpc" "custom_vpc" {
   cidr_block       = var.vpc_cidr
   enable_dns_hostnames = true
   enable_dns_support = true

   tags = {
      name = "custom_vpc"
   }
}

# public subnet 1
resource "aws_subnet" "public_subnet1" {   
   vpc_id            = aws_vpc.custom_vpc.id
   cidr_block        = var.public_subnet1
   availability_zone = var.az1
   map_public_ip_on_launch = true

   tags = {
      name = "public_subnet1"
   }
}

# public subnet 2
resource "aws_subnet" "public_subnet2" {  
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet2
  availability_zone = var.az2
  map_public_ip_on_launch = true

  tags = {
     name = "public_subnet2"
  }
}

# creating internet gateway 
resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.custom_vpc.id

   tags = {
      name = "igw"
   }
}

# creating route table
resource "aws_route_table" "rt" {
   vpc_id = aws_vpc.custom_vpc.id
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      name = "rt"
  }
}

# associate route table to the public subnet 1
resource "aws_route_table_association" "public_rt1" {
   subnet_id      = aws_subnet.public_subnet1.id
   route_table_id = aws_route_table.rt.id
}

# associate route table to the public subnet 2
resource "aws_route_table_association" "public_rt2" {
   subnet_id      = aws_subnet.public_subnet2.id
   route_table_id = aws_route_table.rt.id
}

# SECURITY BLOCK

# create security groups for vpc (web_sg), webserver

# custom vpc security group 
resource "aws_security_group" "web_sg" {
   name        = "web_sg"
   description = "allow inbound HTTP traffic"
   vpc_id      = aws_vpc.custom_vpc.id

   # HTTP from vpc
   ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]     
   }
   ingress {
     from_port       = 22
     to_port         = 22
     protocol        = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
     from_port       = 443
     to_port         = 443
     protocol        = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound rules
  # internet access to anywhere
  egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     name = "web_sg"
  }
}