variable "common_tags" {
  description = "Common tags for ENV"
  type        = map
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
variable "lb_public_subnets" {
  description = "Subnets for AWS ECS Service"
  type        = list
  default     = []
}
variable "lb_security_groups" {
  description = "SG for AWS ECS Service"
  type        = list
  default     = []
}
variable "lb_target_group_arn" {
  description = "AWS ALB TG ARN for cluster config"
  type        = string
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