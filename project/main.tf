# AWS, TLS and Template provider configuration
provider "aws" {
  version = "~> 3.6.0"
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
data "template_file" "ec2_user_data" {
  template = file(var.ec2_user_data_file)
}

# EC2 module
/*module "ec2" {
  source         = "../modules/ec2"
  instance_count = var.instance_count
  instance_name  = var.instance_name

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

  user_data       = data.template_file.ec2_user_data.rendered
  security_groups = module.security_groups.sg_id
  subnet_id       = module.network.public_subnet_ids[var.instance_count]
  common_tags     = var.common_tags
}*/

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

# ALB module
module "ecs_alb" {
  source      = "../modules/alb"
  common_tags = var.ecs_common_tags
  depends_on  = [module.network, module.security_groups]

  lb_internal           = var.ecs_lb_internal
  lb_load_balancer_type = var.ecs_lb_load_balancer_type
  lb_security_groups    = module.security_groups.sg_id
  lb_public_subnets     = module.network.public_subnet_ids

  lb_deletion_protection = var.ecs_lb_deletion_protection

  tg_port        = var.ecs_tg_port
  tg_vpc_id      = module.network.vpc_id
  tg_target_type = var.ecs_tg_target_type

  tg_health_check_port   = var.ecs_tg_health_check_port
  tg_healthy_threshold   = var.ecs_tg_healthy_threshold
  tg_interval            = var.ecs_tg_interval
  tp_protocol            = var.ecs_tp_protocol
  tg_matcher             = var.ecs_tg_matcher
  tg_timeout             = var.ecs_tg_timeout
  tg_health_check_path   = var.ecs_tg_health_check_path
  tg_unhealthy_threshold = var.ecs_tg_unhealthy_threshold

  lb_listener_port     = var.ecs_lb_listener_port
  lb_listener_protocol = var.ecs_lb_listener_protocol
  lb_listener_type     = var.ecs_lb_listener_type
}

# ASG/LC module
data "template_file" "ecs_user_data" {
  template = file(var.ecs_asg_lc_user_data)
  vars = {
    ecs_cluster = "${var.ecs_common_tags["Env"]}-ECS"
  }
}
module "ecs_asg_lc" {
  source      = "../modules/asg_lc"
  common_tags = var.ecs_common_tags
  depends_on  = [module.security_groups]

  lc_filter_name                  = var.ecs_filter_name
  lc_filter_values                = var.ecs_filter_values
  lc_filter_virtualization_name   = var.ecs_filter_virtualization_name
  lc_filter_virtualization_values = var.ecs_filter_virtualization_values
  lc_owners                       = var.ecs_owners

  lc_key_algorithm = var.ecs_key_algorithm
  lc_rsa_bits      = var.ecs_rsa_bits
  lc_key_name      = var.ecs_key_name

  asg_tags                      = var.ecs_asg_tags
  asg_termination_policies      = var.ecs_asg_termination_policies
  asg_vpc_zone_identifier       = module.network.public_subnet_ids
  asg_default_cooldown          = var.ecs_asg_default_cooldown
  asg_health_check_grace_period = var.ecs_asg_health_check_grace_period
  asg_health_check_type         = var.ecs_asg_health_check_type
  asg_max_size                  = var.ecs_asg_max_size
  asg_min_size                  = var.ecs_asg_min_size

  asg_policy_type     = var.ecs_asg_policy_type
  asg_adjustment_type = var.ecs_asg_adjustment_type

  asg_cluster_name     = var.ecs_asg_cluster_name
  ecs_asg_cluster_name = module.ecs.ecs_cluster_name
  asg_metric_name      = var.ecs_asg_metric_name
  asg_namespace        = var.ecs_asg_namespace
  asg_statistic        = var.ecs_asg_statistic
  asg_target_value     = var.ecs_asg_target_value

  asg_lc_instance_type         = var.ecs_asg_lc_instance_type
  asg_lc_user_data             = data.template_file.ecs_user_data.rendered
  asg_lc_enable_monitoring     = var.ecs_asg_lc_enable_monitoring
  asg_lc_associate_public_ip   = var.ecs_asg_lc_associate_public_ip
  asg_lc_volume_type           = var.ecs_asg_lc_volume_type
  asg_lc_volume_size           = var.ecs_asg_lc_volume_size
  asg_lc_delete_on_termination = var.ecs_asg_lc_delete_on_termination
  asg_lc_security_groups       = module.security_groups.sg_id
  aws_iam_instance_profile_id  = module.ecs.aws_iam_ecs_instance_profile_id
}

# Route 53 modul
module "ecs_route_53" {
  source      = "../modules/route_53"
  common_tags = var.ecs_common_tags
  depends_on  = [module.ecs_alb]

  route_53_name           = var.ecs_route_53_name
  route_53_type           = var.ecs_route_53_type
  route_53_evaluate_value = var.ecs_route_53_evaluate_value
  load_balancer_dns_name  = module.ecs_alb.load_balancer_dns_name
  load_balancer_zone_id   = module.ecs_alb.load_balancer_zone_id
}

# ECS module
data "template_file" "ecs_container_definition" {
  template = file(var.ecs_task_def_container_def)
}
module "ecs" {
  source      = "../modules/ecs"
  common_tags = var.ecs_common_tags
  depends_on  = [module.network, module.security_groups, module.ecs_alb]

  #ecs_service_iam_actions     = var.ecs_service_iam_actions
  #ecs_service_iam_type        = var.ecs_service_iam_type
  #ecs_service_iam_identifiers = var.ecs_service_iam_identifiers
  #ecs_service_iam_role_name   = var.ecs_service_iam_role_name
  #ecs_iam_policy_arn          = var.ecs_iam_policy_arn

  ecs_ec2_iam_actions               = var.ecs_ec2_iam_actions
  ecs_ec2_iam_type                  = var.ecs_ec2_iam_type
  ecs_ec2_iam_identifiers           = var.ecs_ec2_iam_identifiers
  ecs_ec2_iam_role_name             = var.ecs_ec2_iam_role_name
  ecs_ec2_iam_policy_arn            = var.ecs_ec2_iam_policy_arn
  ecs_ec2_ssm_iam_policy_arn        = var.ecs_ec2_ssm_iam_policy_arn
  ecs_ec2_iam_instance_profile_name = var.ecs_ec2_iam_instance_profile_name

  ecr_image_tag_mutability = var.ecr_image_tag_mutability
  ecr_policy               = var.ecr_policy

  ecs_task_def_family        = var.ecs_task_def_family
  ecs_task_def_container_def = data.template_file.ecs_container_definition.rendered
  ecs_task_def_network_mode  = var.ecs_task_def_network_mode
  ecs_service_desired_count  = var.ecs_service_desired_count

  lb_security_groups         = module.security_groups.sg_id
  lb_public_subnets          = module.network.public_subnet_ids
  lb_target_group_arn        = module.ecs_alb.target_group_arn
  ecs_service_container_port = var.ecs_service_container_port
  ecs_service_container_name = var.ecs_service_container_name
}
# EKS module