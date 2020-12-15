variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


# SG finalized and tested
/*
variable "common_tags" {
  description = "Common tags for environment"
  type        = map
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID for SG"
  type        = string
  default     = ""
}

variable "sg_value" {
  description = "True/False for security group creation"
  type        = bool
  default     = false
}

variable "sg_ingress_values" {
  description = "List of Ingress ports and etc needed for SG"
  type        = map
  default     = {}
}

variable "sg_egress_values" {
  description = "List of Egress ports and etc needed for SG"
  type        = map
  default     = {}
}
*/