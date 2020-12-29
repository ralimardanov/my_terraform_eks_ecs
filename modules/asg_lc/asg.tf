# AWS ASG configuration

# Description of this ASG:
# if > 80% memory used or more, the autoscaling policy will kick in and create new EC2 instances.
# ASG will keep doing that every 30 seconds (default_cooldown=30), until the criteria is no longer satisfied(memory usage is < 80%). 
resource "aws_autoscaling_group" "asg" {
  name                 = "${var.common_tags["Env"]}-${var.common_tags["Component"]}-ASG"
  termination_policies = var.asg_termination_policies #when a scale down occurs, which instance to be killed first
  vpc_zone_identifier  = var.asg_vpc_zone_identifier
  launch_configuration = aws_launch_configuration.asg_launch_config.name

  default_cooldown          = var.asg_default_cooldown
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size

  lifecycle {
    create_before_destroy = true
  }
  tags = concat(var.asg_tags)
}

# This policy will autoscale instances in case, if it will be needed. Condition is written above.
resource "aws_autoscaling_policy" "memory_asg_policy" {
  name            = "${var.common_tags["Env"]}_${var.common_tags["Component"]}_scale_policy"
  policy_type     = var.asg_policy_type
  adjustment_type = var.asg_adjustment_type

  lifecycle {
    ignore_changes = [
      adjustment_type
    ]
  }
  autoscaling_group_name = aws_autoscaling_group.asg.name

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = var.asg_cluster_name
        value = var.ecs_asg_cluster_name
      }
      metric_name = var.asg_metric_name
      namespace   = var.asg_namespace
      statistic   = var.asg_statistic
    }
    target_value = var.asg_target_value
  }
}