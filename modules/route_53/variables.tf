variable "common_tags" {
  description = "Common tags for ENV"
  type        = map
}

# Route 53 variables
variable "route_53_name" {
  description = "Route 53 name"
  type        = string
  default     = ""
}
variable "route_53_type" {
  description = "Route 53 record type"
  type        = string
  default     = ""
}
variable "route_53_evaluate_value" {
  description = "True/False for Route 53 record evaluate value"
  type        = bool
  default     = false
}

variable "load_balancer_dns_name" {
  description = "LB DNS name for Route53"
  type        = string
  default     = ""
}

variable "load_balancer_zone_id" {
  description = "LB DNS zone id for Route53"
  type        = string
  default     = ""
}