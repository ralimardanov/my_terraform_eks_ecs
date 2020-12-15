#AWS provider configuration
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

#AWS backend configuration
terraform {
  backend "s3" {
    bucket = "terraform-20201215213013426900000001"
    key    = "terraform_tfstate_location"
    region = "us-east-1"
  }
}

/*
module "security_groups" {
  source            = "../modules/security_groups"
  vpc_id            = var.vpc_id
  sg_value          = var.sg_value
  sg_ingress_values = var.sg_ingress_values
  sg_egress_values  = var.sg_egress_values
  common_tags       = var.common_tags
}

module "network" {
  source = "../modules/network"
}
*/