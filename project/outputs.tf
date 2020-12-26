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

# SG outputs
output "sg_module_id" {
  value = module.security_groups.sg_id
}

# EC2 outputs
output "instance_id" {
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
}

/*output "ebs_id" {
  value = module.ec2.ebs_id
}*/

# ECS outputs
output "ecs_private_key_content" {
  value = module.ecs.ecs_private_key_content
}
output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}
output "ecr_repo_name" {
  value = module.ecs.ecr_repo_name
}
/*output "ecs_service_role_arn" {
  value = module.ecs.ecs_service_role_arn
}*/
output "ecs_instance_role_arn" {
  value = module.ecs.ecs_instance_role_arn
}
output "ecs_load_balancer_name" {
  value = module.ecs.ecs_load_balancer_name
}
output "ecs_target_group_arn" {
  value = module.ecs.ecs_target_group_arn
}

#route 53 output
/*output "stg_lb_record" {
  value = module.ecs.stg_lb_record
} */