variable "common_tags" {
  description = "Common tags for ENV"
  type        = map
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
variable "tg_health_check_path" {
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
