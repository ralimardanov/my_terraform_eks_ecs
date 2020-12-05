### This will get all AZ from AWS, so you can refer to it further during VPC creation and etc
data "aws_availability_zones" "available_azs" {}

### This is main VPC and IGW configuration
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.vpc_dns_value
  enable_dns_support   = var.vpc_dns_value

  ### this will merge common_tags on VPC and other resources and give the name to object
  tags = {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-VPC" })
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-IGW" })
  }
}

### NAT resources configuration
resource "aws_eip" "nat" {
  count = var.nat_gtw_count
  vpc   = var.vpc_value_aws_eip

  tags {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-NAT-EIP-${count.index}" })
  }
}

resource "aws_nat_gateway" "nat" {
  count      = var.nat_gtw_count
  depends_on = ["aws_internet_gateway.main"]

  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index) ### select one from public subnets for NAT gateway

  tags {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-NAT-GTW-${count.index}" })
  }
}

### Public subnets, route table and etc configurations 
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone       = data.aws_vailability_zones.available_azs.names[count.index]
  map_public_ip_on_launch = var.public_ip_value

  tags = {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-Public-Subnet-${count.index + 1}" })
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.default_rt_cidr_block
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-Public-RT" })
  }
}
resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

### Private subnets, route table and etc configurations 
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-Private-Subnet-${count.index + 1}" })
  }
}
resource "aws_route_table" "private_rt" {
  count  = var.nat_gtw_count
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.default_rt_cidr_block
    gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-Private-RT-${count.index}" })
  }
}
resource "aws_route_table_association" "private_rt_association" {
  count          = var.nat_gtw_count
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)

  ### or
  ### count          = length(aws_subnet.private_subnets[*].id)
  ### route_table_id = aws_route_table.private_subnets[count.index].id
  ### subnet_id      = element(aws_subnet.private_subnets[*].id, count.index) 
}