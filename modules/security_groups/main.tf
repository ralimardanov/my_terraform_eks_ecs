### This will get all AZ from AWS, so you can refer to it further during VPC creation and etc
data "aws_availability_zones" "available_azs" {}

resource "aws_security_group" "main_sg" {
  count  = var.sg_value ? 1 : 0 ### use in network module
  name   = "${var.common_tags["ENV"]}-SG"
  vpc_id = var.vpc_id

  ### use it like this or use with aws_security_groups_rules ?

  dynamic "ingress" {
    for_each = var.list_of_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.ingress_protocol
      cidr_blocks = var.cidr_blocks
    }

  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-SG" })
}