
# Application Load Balancer for ECS cluster configuration. It will load balance traffic across all our instances.
resource "aws_alb" "ecs_load_balancer" {
  name               = "${var.common_tags["Env"]}-ECS-ALB"
  internal           = var.lb_internal
  load_balancer_type = var.lb_load_balancer_type
  security_groups    = var.lb_security_groups
  subnets            = var.lb_public_subnets

  enable_deletion_protection = var.lb_deletion_protection
  tags                       = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ECS" })
}
resource "aws_alb_target_group" "ecs_target_group" {
  name        = "${var.common_tags["Env"]}-TG"
  port        = var.tg_port
  protocol    = var.tp_protocol
  vpc_id      = var.tg_vpc_id
  target_type = var.tg_target_type

  health_check {
    healthy_threshold   = var.tg_healthy_threshold
    interval            = var.tg_interval
    protocol            = var.tp_protocol
    matcher             = var.tg_matcher
    timeout             = var.tg_timeout
    port                = var.tg_health_check_port
    path                = var.health_check_path
    unhealthy_threshold = var.tg_unhealthy_threshold
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_alb.ecs_load_balancer]
  tags       = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ECS" })
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.ecs_load_balancer.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    target_group_arn = aws_alb_target_group.ecs_target_group.arn
    type             = var.lb_listener_type
  }
}