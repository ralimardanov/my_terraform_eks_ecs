resource "aws_security_group_rule" "ingress_with_self" {
  count = length(var.sg_ingress_with_self_values)

  type              = "ingress"
  from_port         = var.sg_ingress_with_self_values[count.index].from_port
  to_port           = var.sg_ingress_with_self_values[count.index].to_port
  protocol          = var.sg_ingress_with_self_values[count.index].protocol
  description       = var.sg_ingress_with_self_values[count.index].description
  security_group_id = local.sg_id
  self              = var.sg_ingress_with_self
}
resource "aws_security_group_rule" "egress_with_self" {
  count = length(var.sg_egress_with_self_values)

  type              = "egress"
  from_port         = var.sg_egress_with_self_values[count.index].from_port
  to_port           = var.sg_egress_with_self_values[count.index].to_port
  protocol          = var.sg_egress_with_self_values[count.index].protocol
  description       = var.sg_egress_with_self_values[count.index].description
  security_group_id = local.sg_id
  self              = var.sg_egress_with_self
}