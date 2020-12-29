# AWS ECS configuration
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.common_tags["Env"]}-${var.common_tags["Component"]}"
  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-${var.common_tags["Component"]}" })
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = lower("${var.common_tags["Env"]}-ECR") #should be with lowercase
  image_tag_mutability = var.ecr_image_tag_mutability           #this is needed in order to put a latest tag on the most recent image
}
# this ecr policy will keep only last 5 images
resource "aws_ecr_lifecycle_policy" "ecr_main" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = jsonencode(var.ecr_policy)
}

# ECS test task definition(wordpress) and ECS Service for this
resource "aws_ecs_task_definition" "wordpress" {
  family                = var.ecs_task_def_family
  container_definitions = var.ecs_task_def_container_def
  network_mode          = var.ecs_task_def_network_mode #because in ALB configuration I used "ip" as target_type
}
resource "aws_ecs_service" "ecs_service" {
  name = "${var.common_tags["Env"]}-${var.common_tags["Component"]}-Service"
  #iam_role        = aws_iam_role.ecs_service_role.name # this parameter is requered, when you use LB with your service, only if you don't use awsvpc.
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count   = var.ecs_service_desired_count

  network_configuration {
    subnets         = var.lb_public_subnets
    security_groups = var.lb_security_groups
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_port   = var.ecs_service_container_port
    container_name   = var.ecs_service_container_name
  }
}