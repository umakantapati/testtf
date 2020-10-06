# vpc.tf 
# Create VPC/Subnet/Security Group/Network ACL
provider "aws" {
  version = "~> 2.0"
  access_key = var.access_key 
  secret_key = var.secret_key 
  region     = var.region
}
# create the VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "My VPC"
}
} # end resource
# create the Subnet
resource "aws_subnet" "PrivateSubnet-A" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.PrivateSubnet-A
  availability_zone       = var.availabilityZone1
tags = {
   Name = "PrivateSubnet-A"
}
}
resource "aws_subnet" "PrivateSubnet-B" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.PrivateSubnet-B
  availability_zone       = var.availabilityZone2
tags = {
   Name = "PrivateSubnet-B"
}
}
resource "aws_subnet" "PrivateSubnet-C" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.PrivateSubnet-C
  availability_zone       = var.availabilityZone3
tags = {
   Name = "PrivateSubnet-C"
}
}
resource "aws_subnet" "PublicSubnet-A" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.PublicSubnet-A
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone1
tags = {
   Name = "PublicSubnet-A"
}
}
resource "aws_subnet" "PublicSubnet-B" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.PublicSubnet-B
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone2
tags = {
   Name = "PublicSubnet-B"
}
}
resource "aws_subnet" "PublicSubnet-C" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.PublicSubnet-C
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone3
tags = {
   Name = "PublicSubnet-C"
}
} # end resource
# Create the Security Group
resource "aws_security_group" "My_VPC_Security_Group" {
  vpc_id       = aws_vpc.My_VPC.id
  name         = "My VPC Security Group"
  description  = "My VPC Security Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "My VPC Security Group"
   Description = "My VPC Security Group"
}
} 

# Create the Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "My VPC Internet Gateway"
}
} # end resource
# Create the Route Table
resource "aws_route_table" "public_route_table" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "Public Route Table"
}
}
resource "aws_route_table" "private_route_table" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "Private Route Table"
}
} # end resource
# Create the Internet Access Public Subnet
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
} # end resource
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "public_association1" {
  subnet_id      = aws_subnet.PublicSubnet-A.id
  route_table_id = aws_route_table.public_route_table.id
} 
resource "aws_route_table_association" "public_association2" {
  subnet_id      = aws_subnet.PublicSubnet-B.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_association3" {
  subnet_id      = aws_subnet.PublicSubnet-C.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate the Route Table with the Private Subnet
resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.PrivateSubnet-A.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.PrivateSubnet-B.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_association3" {
  subnet_id      = aws_subnet.PrivateSubnet-C.id
  route_table_id = aws_route_table.private_route_table.id
}