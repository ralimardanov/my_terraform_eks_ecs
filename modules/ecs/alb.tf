
# Application Load Balancer for ECS cluster configuration
resource "aws_alb" "ecs_load_balancer" {
  name               = "${var.asg_name}_ECS_ALB"
  internal           = var.lb_internal           #false
  load_balancer_type = var.lb_load_balancer_type #"application"
  security_groups    = var.lb_security_groups
  subnets            = var.lb_public_subnets

  enable_deletion_protection = var.lb_deletion_protection #false
  tags                       = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ECS_ALB" })
}
resource "aws_alb_target_group" "ecs_target_group" {
  name        = "${var.asg_name}_Target_Group"
  port        = var.tg_port     #80
  protocol    = var.tp_protocol #"HTTP"
  vpc_id      = var.tg_vpc_id
  target_type = var.tg_target_type #"ip"

  health_check {
    healthy_threshold   = var.tg_healthy_threshold   #"5"
    interval            = var.tg_interval            #"30"
    protocol            = var.tp_protocol            #"HTTP"
    matcher             = var.tg_matcher             #"200"
    timeout             = var.tg_timeout             #"5"
    path                = var.health_check_path      #"/"
    unhealthy_threshold = var.tg_unhealthy_threshold #"2"
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ECS_Target_Group" })
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.ecs_load_balancer.arn
  port              = var.lb_listener_port     #"80"
  protocol          = var.lb_listener_protocol #"HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecs_target_group.arn
    type             = var.lb_listener_type #"forward"
  }
}