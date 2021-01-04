# Network outputs
output "vpc_id" {
  value = module.network.vpc_id
}
output "vpc_cidr" {
  value = module.network.vpc_cidr
}
output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}
output "aws_route_table_priv_id" {
  value = module.network.aws_route_table_priv_id
}
output "aws_route_table_public_id" {
  value = module.network.aws_route_table_public_id
}

# SG outputs
output "sg_module_id" {
  value = module.security_groups.sg_id
}

# EC2 outputs
/*output "instance_id" {
  value = module.ec2.instance_id
}
output "public_ip" {
  value = module.ec2.public_ip
}
output "private_ip" {
  value = module.ec2.private_ip
}

output "private_key_content" {
  value = module.ec2.private_key_content
}*/

/*output "ebs_id" {
  value = module.ec2.ebs_id
}*/

# ECS outputs
/*output "ecs_lc_private_key_content" {
  value = module.ecs_asg_lc.lc_private_key_content
}
output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}
output "ecr_repo_name" {
  value = module.ecs.ecr_repo_name
}*/
/*output "ecs_service_role_arn" {
  value = module.ecs.ecs_service_role_arn
}*/
/*output "ecs_instance_role_arn" {
  value = module.ecs.ecs_instance_role_arn
}
output "ecs_aws_iam_ecs_instance_profile_id" {
  value = module.ecs.aws_iam_ecs_instance_profile_id
}
output "ecs_load_balancer_dns_name" {
  value = module.ecs_alb.load_balancer_dns_name
}
output "ecs_load_balancer_zone_id" {
  value = module.ecs_alb.load_balancer_zone_id
}
output "ecs_target_group_arn" {
  value = module.ecs_alb.target_group_arn
}

# Route 53 output
output "ecs_lb_record" {
  value = module.ecs_route_53.lb_record
}*/

# EKS outputs
output "eks_ecr_endpoints_sg" {
  value = module.eks_ecr_endpoints_sg.sg_id
}
output "eks_ec2_endpoints_sg" {
  value = module.eks_ec2_endpoints_sg.sg_id
}
output "eks_cluster_sg" {
  value = module.eks_cluster_sg.sg_id
}
output "eks_worker_sg" {
  value = module.eks_worker_sg.sg_id
}

output "eks_cluster_id" {
  value = module.eks.eks_cluster_id
}
output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}
output "eks_cluster_certificat_authority" {
  value = module.eks.eks_cluster_certificat_authority
}
output "eks_worker_private_node_id" {
  value = module.eks.eks_worker_private_node_id
}
output "eks_worker_public_node_id" {
  value = module.eks.eks_worker_public_node_id
}
output "ecr_repo_url" {
  value = module.eks.ecr_repo_url
}
output "ecr_dkr_id" {
  value = module.eks.ecr_dkr_id
}
output "ecr_api_id" {
  value = module.eks.ecr_api_id
}
output "ecr_ec2_id" {
  value = module.eks.ecr_ec2_id
}
output "ecr_s3_id" {
  value = module.eks.ecr_s3_id
}