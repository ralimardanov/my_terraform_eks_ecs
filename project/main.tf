#AWS provider configuration
provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.profile
}

#AWS backend configuration
terraform {
  backend "s3" {
    bucket = "terraform-20201215213013426900000001"
    key    = "terraform_tfstate_location"
    region = "us-east-1"
  }
}

# User Data for EC2 instance configuration. Maybe I should move it to EC2 module?
# what in case if user-data isn't send? Module should work. Take a look.
data "template_file" "user_data" {
    template = "${file(var.user_data_file)}"    
}

#EC2 module
module "ec2" {
  source = "../modules/ec2"

  user_data = "${data.template_file.user_data.rendered}"  
}

#Security Group module
/*
module "security_groups" {
  source            = "../modules/security_groups"
  vpc_id            = var.vpc_id
  sg_value          = var.sg_value
  sg_ingress_values = var.sg_ingress_values
  sg_egress_values  = var.sg_egress_values
  common_tags       = var.common_tags
}

#Network module
module "network" {
  source = "../modules/network"
}
*/