variable "common_tags" {
  description = "Common tags for environment"
  type        = map
}

variable "vpc_id" {
  description = "VPC ID for SG"
  type        = string
}

variable "sg_value" {
  description = "True/False for security group creation"
  type = bool
}

variable "sg_ingress_values" {
  description = "List of Ingress ports and etc needed for SG"
  type = map
}

variable "sg_egress_values" {
  description = "List of Egress ports and etc needed for SG"
  type = map
}