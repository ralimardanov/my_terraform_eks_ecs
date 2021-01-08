variable "region_east" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "region_west" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}
variable "profile_east" {
  description = "AWS profile"
  type        = string
  default     = "default"
}
variable "profile_west" {
  description = "AWS profile"
  type        = string
  default     = "west"
}

### To avoid such copy-paste from other variables.tf, use terragrunt. Or you can hardcore your values in main.tf(not recommended).

### Network variables
variable "net_common_tags" {
  type    = map
  default = {}
}
variable "cidr_block" {
  type    = string
  default = ""
}
variable "vpc_dns_value" {
  type    = bool
  default = false
}
variable "private_subnet_cidr_blocks" {
  type    = list
  default = []
}
variable "public_subnet_cidr_blocks" {
  type    = list
  default = []
}
variable "vpc_value_aws_eip" {
  type    = bool
  default = false
}
variable "nat_gtw_count" {
  type    = number
  default = 0
}
variable "public_ip_value" {
  type    = bool
  default = false
}
variable "default_rt_cidr_block" {
  type    = string
  default = ""
}

### SG variables
variable "sg_common_tags" {
  type    = map
  default = {}
}
variable "sg_value" {
  type    = bool
  default = false
}
variable "sg_ingress_values" {
  type    = list(map(any))
  default = []
}
variable "sg_ingress_cidr_blocks" {
  type    = list(string)
  default = [""]
}
variable "sg_egress_values" {
  type    = list(map(any))
  default = []
}
variable "sg_egress_cidr_blocks" {
  type    = list(string)
  default = [""]
}
variable "sg_ingress_with_source_sg_id_values" {
  type    = list(map(any))
  default = []
}
variable "sg_ingress_with_source_sg_id" {
  type    = string
  default = ""
}
variable "sg_egress_with_source_sg_id_values" {
  type    = list(map(any))
  default = []
}
variable "sg_egress_with_source_sg_id" {
  type    = string
  default = ""
}

variable "sg_ingress_with_self_values" {
  type    = list(map(any))
  default = []
}
variable "sg_ingress_with_self" {
  type    = bool
  default = false
}
variable "sg_egress_with_self_values" {
  type    = list(map(any))
  default = []
}
variable "sg_egress_with_self" {
  type    = bool
  default = false
}

### EC2 variables

# For aws_ami part
variable "ami_filter_name" {
  type    = string
  default = ""
}
variable "ami_filter_values" {
  type    = list(string)
  default = []
}
variable "ami_virtualization_name" {
  type    = string
  default = ""
}
variable "ami_virtualization_values" {
  type    = list(string)
  default = []
}
variable "ami_owners" {
  type    = list(string)
  default = []
}

# EC2 instance variables
variable "ec2_jenkins_common_tags" {
  type    = map
  default = {}
}
variable "instance_count" {
  type    = number
  default = 0
}
variable "iam_policy_document_actions" {
  type    = list(string)
  default = []
}

variable "iam_policy_document_type" {
  type    = string
  default = ""
}

variable "iam_policy_document_identifiers" {
  type    = list(string)
  default = []
}
variable "iam_role_name" {
  type    = string
  default = ""
}
variable "iam_instance_profile_name" {
  type    = string
  default = ""
}
variable "aws_iam_policy_arn" {
  type    = string
  default = ""
}
variable "aws_iam_s3_policy_arn" {
  type    = string
  default = ""
}
variable "instance_type" {
  type    = string
  default = ""
}
variable "ec2_user_data_file" {
  type    = string
  default = ""
}
variable "ec2_public_ip" {
  type    = bool
  default = false
}

# EBS volume variables
variable "ebs_device_name" {
  type    = string
  default = ""
}
variable "ebs_volume_type" {
  type    = string
  default = ""
}
variable "ebs_volume_size" {
  type    = string
  default = ""
}
variable "ebs_delete_on_termination" {
  type    = bool
  default = false
}

# SSH key variables
variable "key_algorithm" {
  type    = string
  default = ""
}
variable "rsa_bits" {
  type    = number
  default = 4096
}
variable "key_name" {
  type    = string
  default = ""
}

### ECS variables
variable "ecs_common_tags" {
  type    = map
  default = {}
}

### AWS AMI variables
variable "ecs_filter_name" {
  type    = string
  default = ""
}
variable "ecs_filter_values" {
  type    = list(string)
  default = []
}
variable "ecs_filter_virtualization_name" {
  type    = string
  default = ""
}

variable "ecs_filter_virtualization_values" {
  type    = list(string)
  default = []
}

variable "ecs_owners" {
  type    = list(string)
  default = []
}

### SSH key variables
variable "ecs_key_algorithm" {
  type    = string
  default = ""
}

variable "ecs_rsa_bits" {
  type    = number
  default = 4096
}

variable "ecs_key_name" {
  description = "SSH key name"
  type        = string
  default     = ""
}

### ECS services variables
/*variable "ecs_service_iam_actions" {
  type = list(string)
  default = []
}

variable "ecs_service_iam_type" {
  type = string
  default = ""
}

variable "ecs_service_iam_identifiers" {
  type = list(string)
  default = []
}

variable "ecs_service_iam_role_name" {
  type = string
  default = ""
}

variable "ecs_iam_policy_arn" {
  type = string
  default = ""
} */

variable "ecs_ec2_iam_actions" {
  type    = list(string)
  default = []
}
variable "ecs_ec2_iam_type" {
  type    = string
  default = ""
}
variable "ecs_ec2_iam_identifiers" {
  type    = list(string)
  default = []
}
variable "ecs_ec2_iam_role_name" {
  type    = string
  default = ""
}
variable "ecs_ec2_iam_policy_arn" {
  type    = string
  default = ""
}
variable "ecs_ec2_ssm_iam_policy_arn" {
  type    = string
  default = ""
}
variable "ecs_ec2_iam_instance_profile_name" {
  type    = string
  default = ""
}

### ECR variables
variable "ecr_image_tag_mutability" {
  type    = string
  default = ""
}
variable "ecr_policy" {
  type    = map
  default = {}
}

### ECS task definition and service variables
variable "ecs_task_def_network_mode" {
  type    = string
  default = ""
}
variable "ecs_task_def_family" {
  type    = string
  default = ""
}
variable "ecs_task_def_container_def" {
  type    = string
  default = ""
}
variable "ecs_service_desired_count" {
  type    = number
  default = 0
}
variable "ecs_service_container_port" {
  type    = number
  default = 0
}
variable "ecs_service_container_name" {
  type    = string
  default = ""
}

### ASG variables
variable "ecs_asg_tags" {
  type    = list
  default = []
}
variable "ecs_asg_termination_policies" {
  type    = list(string)
  default = []
}
variable "ecs_asg_default_cooldown" {
  type    = number
  default = 0
}
variable "ecs_asg_health_check_grace_period" {
  type    = number
  default = 0
}
variable "ecs_asg_health_check_type" {
  type    = string
  default = ""
}
variable "ecs_asg_max_size" {
  type    = number
  default = 0
}
variable "ecs_asg_min_size" {
  type    = number
  default = 0
}

variable "ecs_asg_policy_type" {
  type    = string
  default = ""
}
variable "ecs_asg_adjustment_type" {
  type    = string
  default = ""
}
variable "ecs_asg_cluster_name" {
  type    = string
  default = ""
}
variable "ecs_asg_metric_name" {
  type    = string
  default = ""
}
variable "ecs_asg_namespace" {
  type    = string
  default = ""
}
variable "ecs_asg_statistic" {
  type    = string
  default = ""
}
variable "ecs_asg_target_value" {
  type    = number
  default = 0
}
variable "ecs_asg_lc_instance_type" {
  type    = string
  default = ""
}
variable "ecs_asg_lc_user_data" {
  type    = string
  default = ""
}
variable "ecs_asg_lc_enable_monitoring" {
  type    = bool
  default = false
}
variable "ecs_asg_lc_associate_public_ip" {
  type    = bool
  default = false
}
variable "ecs_asg_lc_volume_type" {
  type    = string
  default = ""
}
variable "ecs_asg_lc_volume_size" {
  type    = number
  default = 0
}
variable "ecs_asg_lc_delete_on_termination" {
  type    = bool
  default = false
}

### ECS ALB variables
variable "ecs_lb_internal" {
  type    = bool
  default = false
}
variable "ecs_lb_load_balancer_type" {
  type    = string
  default = ""
}
variable "ecs_lb_deletion_protection" {
  type    = bool
  default = false
}
### Target group variables
variable "ecs_tg_health_check_port" {
  type    = string
  default = ""
}
variable "ecs_tg_port" {
  type    = number
  default = 0
}
variable "ecs_tp_protocol" {
  type    = string
  default = ""
}
variable "ecs_tg_target_type" {
  type    = string
  default = ""
}
variable "ecs_tg_healthy_threshold" {
  type    = number
  default = 0
}
variable "ecs_tg_interval" {
  type    = number
  default = 0
}
variable "ecs_tg_matcher" {
  type    = number
  default = 0
}
variable "ecs_tg_timeout" {
  type    = number
  default = 0
}
variable "ecs_tg_health_check_path" {
  type    = string
  default = ""
}
variable "ecs_tg_unhealthy_threshold" {
  type    = number
  default = 0
}

### LB listener variables
variable "ecs_lb_listener_port" {
  type    = number
  default = 0
}
variable "ecs_lb_listener_protocol" {
  type    = string
  default = ""
}
variable "ecs_lb_listener_type" {
  type    = string
  default = ""
}

### Route 53 variables
variable "ecs_route_53_name" {
  type    = string
  default = ""
}
variable "ecs_route_53_type" {
  type    = string
  default = ""
}
variable "ecs_route_53_evaluate_value" {
  type    = bool
  default = false
}

### EKS variables
variable "eks_common_tags" {
  type    = map
  default = {}
}
variable "eks_ecr_sg_common_tags" {
  type    = map
  default = {}
}
variable "eks_ec2_sg_common_tags" {
  type    = map
  default = {}
}
variable "eks_worker_sg_common_tags" {
  type    = map
  default = {}
}
variable "eks_sg_ingress_values" {
  type    = list(map(any))
  default = []
}
variable "eks_cluster_sg_ingress_with_source_sg_id_values" {
  type    = list(map(any))
  default = []
}
variable "eks_cluster_sg_egress_with_source_sg_id_values" {
  type    = list(map(any))
  default = []
}

variable "eks_worker_sg_ingress_with_source_sg_id_values" {
  type    = list(map(any))
  default = []
}
variable "eks_worker_sg_ingress_with_self_values" {
  type    = list(map(any))
  default = []
}
variable "eks_worker_sg_ingress_with_self" {
  type    = bool
  default = false
}
variable "eks_worker_sg_egress_values" {
  type    = list(map(any))
  default = []
}
variable "eks_worker_sg_egress_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "eks_ecr_image_tag_mutability" {
  type    = string
  default = ""
}
variable "eks_ecr_policy" {
  type    = map
  default = {}
}
variable "endpoint_private_access" {
  type    = bool
  default = false
}
variable "endpoint_public_access" {
  type    = bool
  default = false
}
variable "eks_ecr_service_name" {
  type    = string
  default = ""
}
variable "eks_vpc_endpoint_type_int" {
  type    = string
  default = ""
}
variable "eks_private_dns_enabled" {
  type    = bool
  default = false
}
variable "eks_ecr_api_service_name" {
  type    = string
  default = ""
}
variable "eks_ec2_service_name" {
  type    = string
  default = ""
}
variable "eks_s3_service_name" {
  type    = string
  default = ""
}
variable "eks_vpc_endpoint_type_gtw" {
  type    = string
  default = ""
}
variable "eks_s3_route_table_ids" {
  type    = list(string)
  default = []
}
variable "eks_worker_ami_type" {
  type    = string
  default = ""
}
variable "eks_worker_disk_size" {
  type    = number
  default = 0
}
variable "eks_worker_instance_types" {
  type    = list(string)
  default = []
}
variable "eks_worker_private_desired_size" {
  type    = number
  default = 0
}
variable "eks_worker_private_max_size" {
  type    = number
  default = 0
}
variable "eks_worker_private_min_size" {
  type    = number
  default = 0
}
variable "eks_worker_public_desired_size" {
  type    = number
  default = 0
}
variable "eks_worker_public_max_size" {
  type    = number
  default = 0
}
variable "eks_worker_public_min_size" {
  type    = number
  default = 0
}
variable "eks_cluster_role_policy" {
  type    = string
  default = ""
}
variable "eks_cluster_policy_arn" {
  type    = string
  default = ""
}
variable "eks_service_policy_arn" {
  type    = string
  default = ""
}
variable "eks_nodes_role_policy" {
  type    = string
  default = ""
}
variable "eks_node_policy_arn" {
  type    = string
  default = ""
}
variable "eks_node_cni_policy_arn" {
  type    = string
  default = ""
}
variable "eks_node_ro_policy_arn" {
  type    = string
  default = ""
}
variable "eks_cluster_autoscaler_policy_name" {
  type    = string
  default = ""
}
variable "eks_cluster_autoscaler_policy" {
  type    = string
  default = ""
}