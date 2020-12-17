variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}
variable "common_tags" {
  type = map
}
### To avoid such copy-paste from other variables.tf, use terragrunt. Or you can hardcore your values in main.tf(not recommended).

# Network variables
variable "cidr_block" {
  type = string
}
variable "vpc_dns_value" {
  type = bool
}
variable "private_subnet_cidr_blocks" {
  type = list
}
variable "public_subnet_cidr_blocks" {
  type = list
}
variable "vpc_value_aws_eip" {
  type = bool
}
variable "nat_gtw_count" {
  type = number
}
variable "public_ip_value" {
  type = bool
}
variable "default_rt_cidr_block" {
  type = string
}

# SG variables
/*variable "vpc_id" {
  type        = string
}*/
variable "sg_value" {
  type = bool
}
variable "sg_ingress_values" {
  type = map
}
variable "sg_egress_values" {
  type = map
}

# EC2 variables
### For aws_ami part
variable "ami_filter_name" {
  type = string
}
variable "ami_filter_values" {
  type = list(string)
}
variable "ami_virtualization_name" {
  type = string
}
variable "ami_virtualization_values" {
  type = list(string)
}
variable "ami_owners" {
  type = list(string)
}

### EC2 instance variables
variable "instance_count" {
  type = number
}
variable "instance_type" {
  type = string
}
variable "user_data_file" {
  type = string
}
variable "ec2_public_ip" {
  type = bool
}

### EBS volume variables
variable "ebs_device_name" {
  type = string
}
variable "ebs_volume_type" {
  type = string
}
variable "ebs_volume_size" {
  type = string
}
variable "ebs_delete_on_termination" {
  type = bool
}

### SSH key variables
variable "key_algorithm" {
  type = string
}
variable "rsa_bits" {
  type = number
}
variable "key_name" {
  type = string
}