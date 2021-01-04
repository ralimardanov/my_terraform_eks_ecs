variable "eks_common_tags" {
  description = "Common tags for EKS cluster"
  type        = map
  default     = {}
}
# cluster variables
variable "eks_ecr_image_tag_mutability" {
  description = "This is for ECR repo"
  type        = string
  default     = ""
}
variable "eks_ecr_policy" {
  description = "Policy for AWS ECR for EKS"
  type        = map
  default     = {}
}
variable "eks_cluster_subnet_ids" {
  description = "Subnet IDS for EKS cluster"
  type        = list(string)
  default     = []
}
variable "eks_security_groups_ids" {
  description = "Both cluster and Worker nodes SG"
  type        = list(string)
  default     = []
}
variable "endpoint_private_access" {
  description = "Private access to Endpoint"
  type        = bool
  default     = false
}
variable "endpoint_public_access" {
  description = "Public access to Endpoint"
  type        = bool
  default     = false
}
# endpoints variables
### ECR
variable "eks_vpc_id" {
  description = "VPC ID for ECR"
  type        = string
  default     = ""
}
variable "eks_ecr_service_name" {
  description = "Enpoint name for EKS"
  type        = string
  default     = ""
}
variable "eks_vpc_endpoint_type_int" {
  description = "Endpoint type for EKS"
  type        = string
  default     = ""
}
variable "eks_private_dns_enabled" {
  description = "True/False for private DNS"
  type        = bool
  default     = false
}
variable "eks_subnet_ids" {
  description = "Subnet ids for ECR"
  type        = list(string)
  default     = []
}
variable "eks_ec2_subnet_ids" {
  description = "Subnet ids for ECR"
  type        = list(string)
  default     = []
}
variable "eks_ecr_security_group_ids" {
  description = "SG for ECR"
  type        = list(string)
  default     = []
}
variable "eks_ecr_api_service_name" {
  description = "ECR API service name for EKS"
  type        = string
  default     = ""
}
### EC2
variable "eks_ec2_service_name" {
  description = "EC2 service name for EKS"
  type        = string
  default     = ""
}
variable "eks_ec2_security_group_ids" {
  description = "SG for EC2"
  type        = list(string)
  default     = []
}
### S3
variable "eks_s3_service_name" {
  description = "S3 service name for EKS"
  type        = string
  default     = ""
}
variable "eks_vpc_endpoint_type_gtw" {
  description = "Endpoint type for S3"
  type        = string
  default     = ""
}
variable "eks_s3_route_table_ids" {
  description = "Route table ids for S3"
  type        = list(string)
  default     = []
}

# nodes variables
variable "eks_worker_ami_type" {
  description = "AMI type for Worker nodes"
  type        = string
  default     = ""
}
variable "eks_worker_disk_size" {
  description = "Disk size for Worker nodes"
  type        = number
  default     = 0
}
variable "eks_worker_instance_types" {
  description = "Instance type for Worker nodes"
  type        = list(string)
  default     = []
}

### private subnet nodes
variable "eks_worker_private_subnet_ids" {
  description = "Private subnets for Private Worker nodes"
  type        = list(string)
  default     = []
}
variable "eks_worker_private_desired_size" {
  description = "Desired number of nodes for Private Worker nodes"
  type        = number
  default     = 0
}
variable "eks_worker_private_max_size" {
  description = "Max number of nodes for Private Worker nodes"
  type        = number
  default     = 0
}
variable "eks_worker_private_min_size" {
  description = "Min number of nodes for Private Worker nodes"
  type        = number
  default     = 0
}

### public subnet nodes
variable "eks_worker_public_subnet_ids" {
  description = "Public subnets for Public Worker nodes"
  type        = list(string)
  default     = []
}
variable "eks_worker_public_desired_size" {
  description = "Desired number of nodes for Public Worker nodes"
  type        = number
  default     = 0
}
variable "eks_worker_public_max_size" {
  description = "Max number of nodes for Public Worker nodes"
  type        = number
  default     = 0
}
variable "eks_worker_public_min_size" {
  description = "Min number of nodes for Public Worker nodes"
  type        = number
  default     = 0
}

# roles variables
variable "eks_cluster_role_policy" {
  description = "Policy for EKS cluster role"
  type        = string
  default     = ""
}
variable "eks_cluster_policy_arn" {
  description = "EKS cluster policy"
  type        = string
  default     = ""
}
variable "eks_service_policy_arn" {
  description = "EKS cluster Service policy"
  type        = string
  default     = ""
}
variable "eks_nodes_role_policy" {
  description = "Policy for Worker nodes role"
  type        = string
  default     = ""
}
variable "eks_node_policy_arn" {
  description = "Policy for Worker nodes"
  type        = string
  default     = ""
}
variable "eks_node_cni_policy_arn" {
  description = "CNI policy for Worker nodes"
  type        = string
  default     = ""
}
variable "eks_node_ro_policy_arn" {
  description = "RO policy for Worker nodes"
  type        = string
  default     = ""
}
variable "eks_cluster_autoscaler_policy_name" {
  description = "Name for EKS cluster policy autoscaler"
  type        = string
  default     = ""
}
variable "eks_cluster_autoscaler_policy" {
  description = "Policy for EKS cluster autoscaler"
  type        = string
  default     = ""
}





