resource "aws_security_group" "main_sg" {
  count  = var.sg_value ? 1 : 0
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-${var.common_tags["Component"]}-SG" })
}
locals {
  sg_id = concat(aws_security_group.main_sg.*.id, [""])[0]
}
resource "aws_security_group_rule" "ingress" {
  count = length(var.sg_ingress_values)

  type              = "ingress"
  from_port         = var.sg_ingress_values[count.index].from_port
  to_port           = var.sg_ingress_values[count.index].to_port
  protocol          = var.sg_ingress_values[count.index].protocol
  description       = var.sg_ingress_values[count.index].description
  security_group_id = local.sg_id
  cidr_blocks       = var.sg_ingress_cidr_blocks
}
resource "aws_security_group_rule" "egress" {
  count = length(var.sg_egress_values)

  type              = "egress"
  from_port         = var.sg_egress_values[count.index].from_port
  to_port           = var.sg_egress_values[count.index].to_port
  protocol          = var.sg_egress_values[count.index].protocol
  description       = var.sg_egress_values[count.index].description
  security_group_id = local.sg_id
  cidr_blocks       = var.sg_egress_cidr_blocks
}
