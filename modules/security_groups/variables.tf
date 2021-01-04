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
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = []
}
variable "sg_ingress_cidr_blocks" {
  description = "Ingress cidr block"
  type        = list(string)
  default     = []
}
variable "sg_egress_values" {
  description = "List of Egress ports and etc needed for SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = []
}
variable "sg_egress_cidr_blocks" {
  description = "Egress cidr block"
  type        = list(string)
  default     = []
}

variable "sg_ingress_with_source_sg_id_values" {
  description = "List of Egress ports and etc needed for SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = []
}
variable "sg_ingress_with_source_sg_id" {
  description = "To allow to/from access from this SG id"
  type        = string
  default     = ""
}
variable "sg_egress_with_source_sg_id_values" {
  description = "List of Egress ports and etc needed for SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = []
}
variable "sg_egress_with_source_sg_id" {
  description = "To allow to/from access from this SG id"
  type        = string
  default     = ""
}

variable "sg_ingress_with_self_values" {
  description = "List of Egress ports and etc needed for SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = []
}
variable "sg_ingress_with_self" {
  description = "True/False sg will be added as a source"
  type        = bool
  default     = false
}
variable "sg_egress_with_self_values" {
  description = "List of Egress ports and etc needed for SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = []
}
variable "sg_egress_with_self" {
  description = "True/False sg will be added as a source"
  type        = bool
  default     = false
}
