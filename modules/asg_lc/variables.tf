variable "common_tags" {
  description = "Common tags for ENV"
  type        = map
}

# AWS AMI variables
variable "lc_filter_name" {
  description = "AWS AMI variable for name"
  type        = string
  default     = ""
}
variable "lc_filter_values" {
  description = "AWS AMI variable for value"
  type        = list(string)
}

variable "lc_filter_virtualization_name" {
  description = "AWS AMI variable name for virtualization-type"
  type        = string
  default     = ""
}

variable "lc_filter_virtualization_values" {
  description = "AWS AMI variable for virtualization-value"
  type        = list(string)
}

variable "lc_owners" {
  description = "AWS AMI variable for AMI owner"
  type        = list(string)
}

#SSH key variables
variable "lc_key_algorithm" {
  description = "Algorithm used for SSH key creation"
  type        = string
  default     = "RSA"
}

variable "lc_rsa_bits" {
  description = "RSA bits used for SSH key creation"
  type        = number
}

variable "lc_key_name" {
  description = "SSH key name"
  type        = string
  default     = ""
}

# ASG variables
variable "asg_tags" {
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
variable "ecs_asg_cluster_name" {
  description = "ECS Cluster name for ASG"
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
variable "aws_iam_instance_profile_id" {
  description = "Instance profile for LC"
  type        = string
  default     = ""
}