variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "vpc_dns_value" {
  description = "Boolean value for components"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Common tags for ENV"
  type        = map
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list
}

variable "vpc_value_aws_eip" {
  description = "Boolean value for AWS NAT EIP"
  type        = bool
  default     = true
}

variable "nat_gtw_count" {
  description = "How many NAT GTW is needed"
  type        = string
}

variable "public_ip_value" {
  description = "Boolean value for public ip assignment on launch for public subnets"
  type        = bool
  default     = true
}

variable "default_rt_cidr_block" {
  description = "Default route for Public and Private RT"
  type        = string
}