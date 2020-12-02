### This will get all AZ from AWS, so you can refer to it further during VPC creation and etc
data "aws_availability_zones" "available_azs" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  #instance_tenancy     = var.instance_tenancy ?
  enable_dns_hostnames = var.vpc_dns_value
  enable_dns_support   = var.vpc_dns__value

  tags = {
    Name = "${var.env_tag}-VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags {
    Name = "${var.env_tag}-IGW"
  }
}

### Public subnets, route table and etc configurations 
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr_blocks, count.index) #read and write down comment about element
  availability_zone       = data.aws_vailability_zones.available_azs.names[count.index]
  map_public_ip_on_launch = var.public_ip_value

  tags = {
    Name = "${var.env_tag}-public-subnet-${count.index + 1}"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.env_tag}-rt"
  }
}
resource "aws_route_table_association" "public_rt_association" {
  count = length(aws_subnet.public_subnets[*].id)

  route_table_id = aws_route_table.public_rt.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  #subnet_id = aws_subnet.public_subnets[count.index].id - which one should you use?
}

### NAT resources:
resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidr_blocks)
  vpc   = var.vpc_value_aws_eip

  tags {
    Name = "${var.env_tag}-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  depends_on = ["aws_internet_gateway.main"]

  count         = length(var.private_subnet_cidr_blocks)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

  tags {
    Name = "${var.env_tag}-nat-gw-${count.index + 1}"
  }
}

### Private subnets, route table and etc configurations 
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name = "${var.env_tag}-private-subnet-${count.index + 1}"
  }
}
### CONTINUE FROM HERE. !ALSO REVIEW THE CODE ABOVE!
resource "aws_route" "private_route" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.main[count.index].id

  timeouts {
    create = "5m" #read about it
  }
}
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.main.id

  tags = {

  }
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  #subnet_id = aws_subnet.private[count.index].id - which one should you use?

  tags = {

  }
}