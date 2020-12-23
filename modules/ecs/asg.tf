# AWS ASG configuration

# Description of this ASG:
# if > 80% memory used or more, the autoscaling policy will kick in and create new EC2 instances.
# ASG will keep doing that every 30 seconds (default_cooldown=30), until the criteria is no longer satisfied(memory usage is < 80%). 
resource "aws_autoscaling_group" "aws_asg" {
  name                 = "${var.common_tags["Env"]}-ASG"
  termination_policies = var.asg_termination_policies #[ "OldestInstance" ] #when a scale down occurs, which instance to be killed first
  vpc_zone_identifier  = var.asg_vpc_zone_identifier  #from vpc module [aws_subnet.public_subnet.id]
  launch_configuration = aws_launch_configuration.aws_asg_launch_config.name

  default_cooldown          = var.asg_default_cooldown          #30
  health_check_grace_period = var.asg_health_check_grace_period #300
  health_check_type         = var.asg_health_check_type         #"ELB"
  max_siz                   = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity

  lifecycle {
    create_before_destroy = true
  }
  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ASG" })
}

# This policy will autoscale instances in case, if it will be needed. Condition is written above.
resource "aws_autoscaling_policy" "aws_asg_policy" {
  name            = "${var.asg_name}_scale_policy"
  policy_type     = var.asg_policy_type     #"TargetTrackingScaling"
  adjustment_type = var.asg_adjustment_type #"ChangeInCapacity"

  lifecycle {
    ignore_changes = [
      adjustment_type
    ]
  }
  autoscaling_group_name = aws_autoscaling_group.aws_asg.name

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = var.asg_cluster_name #"ClusterName"
        value = "${var.common_tags["Env"]}-ECS"
      }
      metric_name = var.asg_metric_name #"MemoryReservation"
      namespace   = var.asg_namespace   #"AWS/ECS"
      statistic   = var.asg_statistic   #"Average"
    }
    target_value = var.asg_target_value # 80.0
  }
  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-ASG" })
}