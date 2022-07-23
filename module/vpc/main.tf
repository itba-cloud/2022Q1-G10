resource "aws_vpc" "this" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "public" {    # Creating Public Subnets
  for_each = {for entry in flatten([for entry in var.availability_zones: [for subnet in entry.public_subnet_cidrs: {
    availability_zone = entry.az
    subnet = subnet
  }]]): "${entry.availability_zone}-${entry.subnet}" => {
    availability_zone = entry.availability_zone
    subnet = entry.subnet
  }}

  map_public_ip_on_launch = true
  availability_zone = "${each.value.availability_zone}"
  vpc_id =  aws_vpc.this.id
  cidr_block = "${each.value.subnet}"          # CIDR block of public subnets
}

resource "aws_subnet" "private" {
  for_each = {for entry in flatten([for entry in var.availability_zones: [for subnet in entry.private_subnet_cidrs: {
    availability_zone = entry.az
    subnet = subnet
  }]]): "${entry.availability_zone}-${entry.subnet}" => {
    availability_zone = entry.availability_zone
    subnet = entry.subnet
  }}

  map_public_ip_on_launch = false
  availability_zone = "${each.value.availability_zone}"
  vpc_id =  aws_vpc.this.id
  cidr_block = "${each.value.subnet}"          # CIDR block of public subnets
}

