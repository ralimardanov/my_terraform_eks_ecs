resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.vpc_dns_value
  enable_dns_support   = var.vpc_dns__value

  tags = {

  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.main.id
  cidr_block = element
  availability_zone =
  map_public_ip_on_launch = var.public_ip_value

  tags = {
    
  }
}

resource "aws_route_table" "public" {
  
}
