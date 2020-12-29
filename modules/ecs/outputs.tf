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
output "aws_iam_ecs_instance_profile_id" {
  value = aws_iam_instance_profile.ecs_instance_profile.id
}