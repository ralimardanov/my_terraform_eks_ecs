variable "common_tags" {
  description = "Common tags for environment"
  type        = map
}

variable "vpc_id" {
  description = "VPC ID for SG"
  type        = string
}