# Best AMI for ECS
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = var.lc_filter_name
    values = var.lc_filter_values
  }

  filter {
    name   = var.lc_filter_virtualization_name
    values = var.lc_filter_virtualization_values
  }

  owners = var.lc_owners
}

# SSH key generation for ECS instances
resource "tls_private_key" "lc_key" {
  algorithm = var.lc_key_algorithm
  rsa_bits  = var.lc_rsa_bits
}
resource "aws_key_pair" "lc_key_pair" {
  key_name   = var.lc_key_name
  public_key = tls_private_key.lc_key.public_key_openssh
}

# AWS Launch Configuration for ASG
resource "aws_launch_configuration" "asg_launch_config" {
  name          = "${var.common_tags["Env"]}_${var.common_tags["Component"]}_asg_launch_config"
  image_id      = data.aws_ami.ami.id
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
  key_name             = aws_key_pair.lc_key_pair.key_name
  iam_instance_profile = var.aws_iam_instance_profile_id
}