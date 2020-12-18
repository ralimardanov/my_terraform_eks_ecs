# AWS, TLS and Template provider configuration
provider "aws" {
  version = "~> 2.70.0"
  region  = var.region
  profile = var.profile
}
provider "template" {
  version = "~> 2.2.0"
}
provider "tls" {
  version = "~> 3.0.0"
}

#AWS backend configuration
terraform {
  backend "s3" {
    bucket = "terraform-20201215213013426900000001"
    key    = "terraform_tfstate_location"
    region = "us-east-1"
  }
}

# User Data for EC2 instance configuration. 
data "template_file" "user_data" {
  template = file(var.user_data_file)
}

# EC2 module
module "ec2" {
  source         = "../modules/ec2"
  instance_count = var.instance_count

  ami_filter_name                 = var.ami_filter_name
  ami_filter_values               = var.ami_filter_values
  ami_virtualization_name         = var.ami_virtualization_name
  ami_virtualization_values       = var.ami_virtualization_values
  ami_owners                      = var.ami_owners
  instance_type                   = var.instance_type
  ec2_public_ip                   = var.ec2_public_ip
  iam_policy_document_actions     = var.iam_policy_document_actions
  iam_policy_document_type        = var.iam_policy_document_type
  iam_policy_document_identifiers = var.iam_policy_document_identifiers
  iam_role_name                   = var.iam_role_name
  iam_instance_profile_name       = var.iam_instance_profile_name
  aws_iam_policy_arn              = var.aws_iam_policy_arn

  ebs_device_name           = var.ebs_device_name
  ebs_volume_type           = var.ebs_volume_type
  ebs_volume_size           = var.ebs_volume_size
  ebs_delete_on_termination = var.ebs_delete_on_termination

  key_algorithm = var.key_algorithm
  rsa_bits      = var.rsa_bits
  key_name      = var.key_name

  user_data       = data.template_file.user_data.rendered
  security_groups = module.security_groups.sg_id
  subnet_id       = module.network.public_subnet_ids[var.instance_count]
  common_tags     = var.common_tags
}

# Network module
module "network" {
  source = "../modules/network"

  cidr_block                 = var.cidr_block
  vpc_dns_value              = var.vpc_dns_value
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  vpc_value_aws_eip          = var.vpc_value_aws_eip
  nat_gtw_count              = var.nat_gtw_count
  public_ip_value            = var.public_ip_value
  default_rt_cidr_block      = var.default_rt_cidr_block
  common_tags                = var.common_tags
}

# Security Group module
module "security_groups" {
  source = "../modules/security_groups"

  vpc_id            = module.network.vpc_id
  sg_value          = var.sg_value
  sg_ingress_values = var.sg_ingress_values
  sg_egress_values  = var.sg_egress_values
  common_tags       = var.common_tags
}

# ECS module

# EKS module