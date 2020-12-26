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

### Network variables
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

### SG variables
variable "sg_value" {
  type = bool
}
variable "sg_ingress_values" {
  type = map
}
variable "sg_egress_values" {
  type = map
}

### EC2 variables

# For aws_ami part
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

# EC2 instance variables
variable "instance_name" {
  type = string
}
variable "instance_count" {
  type = number
}
variable "iam_policy_document_actions" {
  type = list(string)
}

variable "iam_policy_document_type" {
  type = string
}

variable "iam_policy_document_identifiers" {
  type = list(string)
}
variable "iam_role_name" {
  type = string
}
variable "iam_instance_profile_name" {
  type = string
}
variable "aws_iam_policy_arn" {
  type = string
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

# EBS volume variables
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

# SSH key variables
variable "key_algorithm" {
  type = string
}
variable "rsa_bits" {
  type = number
}
variable "key_name" {
  type = string
}

### ECS variables
### AWS AMI variables
variable "ecs_filter_name" {
  type = string
}
variable "ecs_filter_values" {
  type = list(string)
}
variable "ecs_filter_virtualization_name" {
  type = string
}

variable "ecs_filter_virtualization_values" {
  type = list(string)
}

variable "ecs_owners" {
  type = list(string)
}

### SSH key variables
variable "ecs_key_algorithm" {
  type = string
}

variable "ecs_rsa_bits" {
  type = number
}

variable "ecs_key_name" {
  description = "SSH key name"
  type        = string
  default     = ""
}

### ECS services variables
/*variable "ecs_service_iam_actions" {
  type = list(string)
}

variable "ecs_service_iam_type" {
  type = string
}

variable "ecs_service_iam_identifiers" {
  type = list(string)
}

variable "ecs_service_iam_role_name" {
  type = string
}

variable "ecs_iam_policy_arn" {
  type = string
} */

variable "ecs_ec2_iam_actions" {
  type = list(string)
}
variable "ecs_ec2_iam_type" {
  type = string
}
variable "ecs_ec2_iam_identifiers" {
  type = list(string)
}
variable "ecs_ec2_iam_role_name" {
  type = string
}
variable "ecs_ec2_iam_policy_arn" {
  type = string
}
variable "ecs_ec2_ssm_iam_policy_arn" {
  type = string
}
variable "ecs_ec2_iam_instance_profile_name" {
  type = string
}

### ECR variables
variable "ecr_image_tag_mutability" {
  type = string
}
variable "ecr_policy" {
  type = map
}

### ECS task definition and service variables
variable "ecs_task_def_network_mode" {
  type = string
}
variable "ecs_task_def_family" {
  type = string
}
variable "ecs_task_def_container_def" {
  type = string
}
variable "ecs_service_desired_count" {
  type = number
}
variable "ecs_service_container_port" {
  type = number
}
variable "ecs_service_container_name" {
  type = string
}

### ASG variables
variable "ecs_asg_tags" {
  type = list
}
variable "asg_termination_policies" {
  type = list(string)
}
variable "asg_vpc_zone_identifier" {
  type = list
}
variable "asg_default_cooldown" {
  type = number
}
variable "asg_health_check_grace_period" {
  type = number
}
variable "asg_health_check_type" {
  type = string
}
variable "asg_max_size" {
  type = number
}
variable "asg_min_size" {
  type = number
}

variable "asg_policy_type" {
  type = string
}
variable "asg_adjustment_type" {
  type = string
}
variable "asg_cluster_name" {
  type = string
}
variable "asg_metric_name" {
  type = string
}
variable "asg_namespace" {
  type = string
}
variable "asg_statistic" {
  type = string
}
variable "asg_target_value" {
  type = number
}
variable "asg_lc_instance_type" {
  type = string
}
variable "asg_lc_user_data" {
  type = string
}
variable "asg_lc_enable_monitoring" {
  type = bool
}
variable "asg_lc_associate_public_ip" {
  type = bool
}
variable "asg_lc_volume_type" {
  type = string
}
variable "asg_lc_volume_size" {
  type = number
}
variable "asg_lc_delete_on_termination" {
  type = bool
}
variable "asg_lc_security_groups" {
  type = list
}

### ALB variables
variable "lb_internal" {
  type = bool
}
variable "lb_load_balancer_type" {
  type = string
}
variable "lb_security_groups" {
  type = list
}
variable "lb_public_subnets" {
  type = list
}
variable "lb_deletion_protection" {
  type = bool
}
### Target group variables
variable "tg_health_check_port" {
  type = string
}
variable "tg_port" {
  type = number
}
variable "tp_protocol" {
  type = string
}
variable "tg_vpc_id" {
  type = string
}
variable "tg_target_type" {
  type = string
}
variable "tg_healthy_threshold" {
  type = number
}
variable "tg_interval" {
  type = number
}
variable "tg_matcher" {
  type = number
}
variable "tg_timeout" {
  type = number
}
variable "health_check_path" {
  type = string
}
variable "tg_unhealthy_threshold" {
  type = number
}

### LB listener variables
variable "lb_listener_port" {
  type = number
}
variable "lb_listener_protocol" {
  type = string
}
variable "lb_listener_type" {
  type = string
}

# Route 53 variables
/*variable "route53_name" {
  type = string
}
variable "route53_type" {
  type = string
}
variable "route_53_evaluate_value" {
  type = bool
} */