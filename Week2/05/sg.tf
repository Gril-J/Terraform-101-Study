resource "aws_security_group" "grilserver_sg" {
  name        = "${var.namespace}-server-sg"
  description = "${var.namespace}-server-sg"

  dynamic "ingress" {
    for_each = var.grilserveringress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.grilserveregress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = {
    Name = "${var.namespace}-server-sg"
  }
}