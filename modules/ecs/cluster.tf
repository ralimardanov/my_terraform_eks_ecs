# I'll use ASG and launch configuration right here. It can be used as additional module also.
# Best AMI for ECS
data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = var.filter_name   # "name"
    values = var.filter_values # [ "amzn2-ami-ecs-*" ] - ECS optimized image
  }

  filter {
    name   = var.filter_virtualization_name   #"virtualization-type"
    values = var.filter_virtualization_values #[ "hvm" ]
  }

  owners = var.owners # [ "amazon" ]
}

# SSH key generation for ECS instances
resource "tls_private_key" "ecs_key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.rsa_bits
}
resource "aws_key_pair" "ecs_key_pair" {
  key_name   = var.ecs_key_name
  public_key = tls_private_key.ecs_key.public_key_openssh
}

# AWS ECS configuration
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.common_tags["Env"]}-ECS"
  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ECS" })
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = "${var.common_tags["Env"]}-ECR"
  image_tag_mutability = var.ecr_image_tag_mutability #this is needed in order to put a latest tag on the most recent image #"MUTABLE"
}
# this ecr policy will keep only last 5 images
resource "aws_ecr_lifecycle_policy" "ecr_main" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = var.ecr_policy /*jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 10 images"
      acction = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 5
      }
    }]
  })*/
}

# ECS test task definition(wordpress) and ECS Service for this
data "aws_ecs_task_definition" "wordpress" {
  task_definition = aws_ecs_task_definition.wordpress.family
}
resource "aws_ecs_task_definition" "wordpress" {
  family                = var.ecs_task_def_family #"hello_world"
  container_definitions = var.ecs_task_def_container_def
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.common_tags["Env"]}-ECS-Service"
  iam_role        = aws_iam_role.ecs_service_role.name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.wordpress.family}:${max("${aws_ecs_task_definition.wordpress.revision}", "${data.aws_ecs_task_definition.wordpress.revision}")}" #This line will track the latest ACTIVE revision
  desired_count   = var.ecs_service_desired_count                                                                                                                               #2

  load_balancer {
    target_group_arn = aws_alb_target_group.ecs_target_group.arn
    container_port   = var.ecs_service_container_port #80
    container_name   = var.ecs_service_container_name #wordpress
  }
}