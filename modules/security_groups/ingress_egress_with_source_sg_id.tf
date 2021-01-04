resource "aws_security_group_rule" "ingress_with_source_sg_id" {
  count = length(var.sg_ingress_with_source_sg_id_values)

  type                     = "ingress"
  from_port                = var.sg_ingress_with_source_sg_id_values[count.index].from_port
  to_port                  = var.sg_ingress_with_source_sg_id_values[count.index].to_port
  protocol                 = var.sg_ingress_with_source_sg_id_values[count.index].protocol
  description              = var.sg_ingress_with_source_sg_id_values[count.index].description
  security_group_id        = local.sg_id
  source_security_group_id = var.sg_ingress_with_source_sg_id
}
resource "aws_security_group_rule" "egress_with_source_sg_id" {
  count = length(var.sg_egress_with_source_sg_id_values)

  type                     = "egress"
  from_port                = var.sg_egress_with_source_sg_id_values[count.index].from_port
  to_port                  = var.sg_egress_with_source_sg_id_values[count.index].to_port
  protocol                 = var.sg_egress_with_source_sg_id_values[count.index].protocol
  description              = var.sg_egress_with_source_sg_id_values[count.index].description
  security_group_id        = local.sg_id
  source_security_group_id = var.sg_egress_with_source_sg_id
}