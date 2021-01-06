# For aws_ami part
variable "ami_filter_name" {
  description = "Name to filter AMIs"
  type        = string
  default     = "name"
}

variable "ami_filter_values" {
  description = "Values to filter with"
  type        = list(string)
  default     = [""]
}

variable "ami_virtualization_name" {
  description = "Virtualization name to filter AMIs"
  type        = string
  default     = "virtualization-type"
}

variable "ami_virtualization_values" {
  description = "Virtualization values to filter AMIs"
  type        = list(string)
  default     = ["hvm"]
}

variable "ami_owners" {
  description = "AMI owners on AWS"
  type        = list(string)
  default     = ["amazon"]
}

#EC2 instance variables
variable "instance_count" {
  description = "Count of EC2 instances"
  type        = number
}
variable "common_tags" {
  description = "Tags for EC2 instance"
  type        = map
  default     = {}
}

variable "instance_type" {
  description = "Instance types"
  type        = string
  default     = ""
}
variable "iam_policy_document_actions" {
  description = "Actions for policy used for IAM role for EC2 instance"
  type        = list(string)
  default     = [""]
}

variable "iam_policy_document_type" {
  description = "Type for policy used for IAM role for EC2 instance"
  type        = string
  default     = ""
}

variable "iam_policy_document_identifiers" {
  description = "Identifiers for policy used for IAM role for EC2 instance"
  type        = list(string)
  default     = [""]
}

variable "iam_role_name" {
  description = "Name of IAM role for EC2"
  type        = string
  default     = ""
}

variable "iam_instance_profile_name" {
  description = "Name of IAM instance profile for EC2"
  type        = string
  default     = ""
}

variable "aws_iam_policy_arn" {
  description = "SSM role ARN for policy attachment"
  type        = string
  default     = ""
}
variable "security_groups" {
  description = "Security group ID for EC2 instance"
  type        = list(string)
  default     = [""]
}

/*variable "ssh_key_name" {
  description = "SSH key name for EC2 instance"
  type        = string
  default     = ""
}*/

variable "user_data" {
  description = "User data for Jenkins, Docker, Docker-Compose installation"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Subnet ID for EC2 instance"
  type        = list(string)
  default     = []
}

variable "ec2_public_ip" {
  description = "True/False for public ip allocation to EC2 instance"
  type        = bool
  default     = false
}

#EBS volume variables

variable "ebs_device_name" {
  description = "EBS device name for EC2"
  type        = string
  default     = ""
}
variable "ebs_volume_type" {
  description = "EBS volume type for EC2"
  type        = string
  default     = "standard"
}
variable "ebs_volume_size" {
  description = "EBS volume size for EC2"
  type        = number
}
variable "ebs_delete_on_termination" {
  description = "True/False boolean for EBS volume delete on termination"
  type        = bool
  default     = false
}

# SSH key variables
variable "key_algorithm" {
  description = "Algorithm used for SSH key creation"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "RSA bits used for SSH key creation"
  type        = number
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = ""
}