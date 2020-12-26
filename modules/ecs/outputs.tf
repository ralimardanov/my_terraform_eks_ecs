output "ecs_private_key_content" {
  sensitive = true
  value     = join("", tls_private_key.ecs_key.*.private_key_pem)
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
output "ecr_repo_name" {
  value = aws_ecr_repository.ecr_repo.name
}
/*output "ecs_service_role_arn" {
  value = aws_iam_role.ecs_service_role.arn
}*/
output "ecs_instance_role_arn" {
  value = aws_iam_role.ecs_instance_role.arn
}
output "ecs_load_balancer_name" {
  value = aws_alb.ecs_load_balancer.name
}
output "ecs_target_group_arn" {
  value = aws_alb_target_group.ecs_target_group.arn
}

#route 53 output
/*output "stg_lb_record" {
  value = aws_route53_record.stg_lb_record.name
}*/