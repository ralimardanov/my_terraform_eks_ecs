### This will get all AZ from AWS, so you can refer to it further during VPC creation and etc
data "aws_availability_zones" "available_azs" {}

resource "aws_security_group" "main_sg" {
  count  = var.sg_value ? 1 : 0 
  name   = "${var.common_tags["ENV"]}-SG"
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
  } 

  dynamic "ingress" {
    for_each = var.sg_ingress_values
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
 }

  dynamic "egress" {
    for_each = var.sg_egress_values
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
 }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-SG" })
}