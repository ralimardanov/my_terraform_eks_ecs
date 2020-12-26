variable "common_tags" {
  description = "Common tags for ENV"
  type        = map
}

# AWS AMI variables
variable "ecs_filter_name" {
  description = "AWS AMI variable for name"
  type        = string
  default     = ""
}
variable "ecs_filter_values" {
  description = "AWS AMI variable for value"
  type        = list(string)
}

variable "ecs_filter_virtualization_name" {
  description = "AWS AMI variable name for virtualization-type"
  type        = string
  default     = ""
}

variable "ecs_filter_virtualization_values" {
  description = "AWS AMI variable for virtualization-value"
  type        = list(string)
}

variable "ecs_owners" {
  description = "AWS AMI variable for AMI owner"
  type        = list(string)
}

#SSH key variables
variable "ecs_key_algorithm" {
  description = "Algorithm used for SSH key creation"
  type        = string
  default     = "RSA"
}

variable "ecs_rsa_bits" {
  description = "RSA bits used for SSH key creation"
  type        = number
}

variable "ecs_key_name" {
  description = "SSH key name"
  type        = string
  default     = ""
}

# ECS services variables
/*variable "ecs_service_iam_actions" {
  description = "AWS ECS services variables"
  type        = list(string)
}

variable "ecs_service_iam_type" {
  description = "AWS ECS services variables"
  type        = string
  default     = ""
}

variable "ecs_service_iam_identifiers" {
  description = "AWS ECS services variables"
  type        = list(string)
}

variable "ecs_service_iam_role_name" {
  description = "Name for AWS ECS service"
  type        = string
  default     = ""
}

variable "ecs_iam_policy_arn" {
  description = "AWS ECS policy ARN"
  type        = string
  default     = ""
} */

variable "ecs_ec2_iam_actions" {
  description = "AWS ECS instance variable"
  type        = list(string)
}
variable "ecs_ec2_iam_type" {
  description = "AWS ECS instance IAM type"
  type        = string
  default     = ""
}
variable "ecs_ec2_iam_identifiers" {
  description = "AWS ECS instance IAM identifiers"
  type        = list(string)
}
variable "ecs_ec2_iam_role_name" {
  description = "AWS ECS instance role name"
  type        = string
  default     = ""
}
variable "ecs_ec2_iam_policy_arn" {
  description = "Policy for ECS EC2 IAM"
  type        = string
  default     = ""
}
variable "ecs_ec2_ssm_iam_policy_arn" {
  description = "SSM policy for ECS EC2 role"
  type        = string
  default     = ""

}
variable "ecs_ec2_iam_instance_profile_name" {
  description = "AWS ECS EC2 instance profile name"
  type        = string
  default     = ""
}

# ECR variables
variable "ecr_image_tag_mutability" {
  description = "ECR mutability variable"
  type        = string
  default     = ""
}
variable "ecr_policy" {
  description = "Policy for AWS ECR"
  type        = map
}

# ECS task definition and service variables
variable "ecs_task_def_network_mode" {
  description = "Network mode for Task Definition"
  type        = string
  default     = ""
}
variable "ecs_task_def_family" {
  description = "ECS task definition family"
  type        = string
  default     = ""
}
variable "ecs_task_def_container_def" {
  description = "AWS ECS container definition"
  type        = string
}
variable "ecs_service_desired_count" {
  description = "ECS service desired count"
  type        = number
}
variable "ecs_service_container_port" {
  description = "ECS service container port"
  type        = number
}
variable "ecs_service_container_name" {
  description = "ECS service container name"
  type        = string
  default     = ""
}

# ASG variables
variable "ecs_asg_tags" {
  description = "Tags for ASG instances"
  type        = list
}
variable "asg_termination_policies" {
  description = "Policy for ASG instance termination"
  type        = list(string)
}
variable "asg_vpc_zone_identifier" {
  description = "VPC zone identifier"
  type        = list
}
variable "asg_default_cooldown" {
  type = number
}
variable "asg_health_check_grace_period" {
  type = number
}
variable "asg_health_check_type" {
  type    = string
  default = ""
}
variable "asg_max_size" {
  type = number
}
variable "asg_min_size" {
  type = number
}
variable "asg_policy_type" {
  description = "Policy type for scaling"
  type        = string
  default     = ""
}
variable "asg_adjustment_type" {
  description = "Adjustment type for Scaling"
  type        = string
  default     = ""
}
variable "asg_cluster_name" {
  description = "Cluster name for ASG"
  type        = string
  default     = ""
}
variable "asg_metric_name" {
  description = "Metric name for ASG"
  type        = string
  default     = ""
}
variable "asg_namespace" {
  description = "Namespace for ASG"
  type        = string
  default     = ""
}
variable "asg_statistic" {
  description = "Statistic for ASG"
  type        = string
  default     = ""
}
variable "asg_target_value" {
  description = "Target value for ASG"
  type        = number
}
variable "asg_lc_instance_type" {
  description = "Instance type for ASG Launch config"
  type        = string
  default     = ""
}
variable "asg_lc_user_data" {
  description = "Instance user-data for ASG Launch config"
  type        = string
  default     = ""
}
variable "asg_lc_enable_monitoring" {
  description = "True/False to enable monitoring for ECS cluster"
  type        = bool
  default     = false
}
variable "asg_lc_associate_public_ip" {
  description = "True/False for EC2 instance public ip association"
  type        = bool
  default     = false
}
variable "asg_lc_volume_type" {
  description = "Volume type for ASG LC"
  type        = string
  default     = ""
}
variable "asg_lc_volume_size" {
  description = "Volume size for ASG LC"
  type        = number
}
variable "asg_lc_delete_on_termination" {
  description = "True/False for ASG volume delete on termination"
  type        = bool
  default     = false
}
variable "asg_lc_security_groups" {
  description = "Security Groups for ASG LC"
  type        = list
  default     = []
}

# ALB variables
variable "lb_internal" {
  description = "True/False for LB to be internal"
  type        = bool
  default     = false
}
variable "lb_load_balancer_type" {
  description = "LB type"
  type        = string
  default     = ""
}
variable "lb_security_groups" {
  description = "Security groups for LB"
  type        = list
  default     = []
}
variable "lb_public_subnets" {
  description = "Public subnets for LB"
  type        = list
  default     = []
}
variable "lb_deletion_protection" {
  description = "True/False LB deletion protection"
  type        = bool
  default     = false
}
# Target group variables
variable "tg_health_check_port" {
  description = "Port for TG health check"
  type        = string
  default     = ""
}
variable "tg_port" {
  description = "Port for target group"
  type        = number
}
variable "tp_protocol" {
  description = "Protocol for target group"
  type        = string
  default     = ""
}
variable "tg_vpc_id" {
  description = "VPC ID for Target Group"
  type        = string
  default     = ""
}
variable "tg_target_type" {
  description = "Target type for Target Group"
  type        = string
  default     = ""
}
variable "tg_healthy_threshold" {
  description = "Healthy threshold for Target Group"
  type        = number
}
variable "tg_interval" {
  description = "Interval for Target Group"
  type        = number
}
variable "tg_matcher" {
  description = "Matcher for Target Group"
  type        = number
}
variable "tg_timeout" {
  description = "Timeout for Target Group"
  type        = number
}
variable "health_check_path" {
  description = "Path to check health"
  type        = string
  default     = ""
}
variable "tg_unhealthy_threshold" {
  description = "Unhealthy threshold for Target Group"
  type        = number
}

# LB listener variables
variable "lb_listener_port" {
  description = "Listener port for LB"
  type        = number
}
variable "lb_listener_protocol" {
  description = "Listener protocol for LB"
  type        = string
  default     = ""
}
variable "lb_listener_type" {
  description = "Listener type for LB"
  type        = string
  default     = ""
}

# Route 53 variables
/*variable "route53_name" {
  description = "Route 53 name"
  type = string
  default = ""
}
variable "route53_type" {
  description = "Route 53 record type"
  type = string
  default = ""
}
variable "route_53_evaluate_value" {
  description = "True/False for Route 53 record evaluate value"
  type = bool
  default = false  
}
*/