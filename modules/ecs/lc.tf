# AWS Launch Configuration for ASG
resource "aws_launch_configuration" "aws_asg_launch_config" {
  name          = "${var.common_tags["Env"]}_asg_launch_config"
  image_id      = data.aws_ami.ecs.id
  instance_type = var.asg_lc_instance_type
  user_data     = var.asg_lc_user_data

  enable_monitoring           = var.asg_lc_enable_monitoring
  associate_public_ip_address = var.asg_lc_associate_public_ip

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type           = var.asg_lc_volume_type
    volume_size           = var.asg_lc_volume_size
    delete_on_termination = var.asg_lc_delete_on_termination
  }

  security_groups      = var.asg_lc_security_groups
  key_name             = aws_key_pair.ecs_key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.id
}