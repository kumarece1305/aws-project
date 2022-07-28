## Create the VPC
 resource "aws_vpc" "vpc" {                # Creating VPC here
   cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"

   tags = { name= "${local.stage_env}_vpc"
   }
 }

 locals {
     stage_env="staging"
 }

## Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "igw" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.vpc.id               # vpc_id will be generated after we create VPC
 }

## Create a Public Subnets.
 resource "aws_subnet" "publicsubnet" {    # Creating Public Subnets
   vpc_id =  aws_vpc.vpc.id
   cidr_block = "${var.public_subnets}"        # CIDR block of public subnets
   
   tags = { name= "${local.stage_env}_pub_sn"
   }
 }

## Create a Private Subnet                   # Creating Private Subnets
 resource "aws_subnet" "privatesubnet" {
   vpc_id =  aws_vpc.vpc.id
   cidr_block = "${var.private_subnets}"          # CIDR block of private subnets

   tags = { name= "${local.stage_env}_pri_vpc"
   }
 }

## Route table for Public Subnet's
 resource "aws_route_table" "pubrt" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.vpc.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.igw.id
     }

    tags = { name= "${local.stage_env}_pub_rt"
   }
 }
## Route table for Private Subnet's
 resource "aws_route_table" "prirt" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.vpc.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.natgw.id
   }
   tags = { name= "${local.stage_env}_pri_rt"
   }
 }
## Route table Association with Public Subnet's
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnet.id
    route_table_id = aws_route_table.pubrt.id
 }
## Route table Association with Private Subnet's
 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnet.id
    route_table_id = aws_route_table.prirt.id
 }
resource "aws_eip" "natip" {
   vpc   = true
 }
## Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "natgw" {
   allocation_id = aws_eip.natip.id
   subnet_id = aws_subnet.privatesubnet.id

   tags = { name= "${local.stage_env}_nat_gw"
   }
 }