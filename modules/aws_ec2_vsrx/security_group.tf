resource "aws_security_group" "fxp0" {
  name        = "fxp0"
  description = "Allow ssh traffic"
  vpc_id      = var.jnpr_vpc_id
}


resource "aws_security_group_rule" "ssh-client" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.fxp0.id
  cidr_blocks       = var.mymngip[var.vpc_name]
}

resource "aws_security_group_rule" "ssh-fxp0" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.fxp0.id
  source_security_group_id = aws_security_group.fxp0.id
}

resource "aws_security_group_rule" "fxp0-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.fxp0.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "ge-000" {
  name        = "ge-000"
  description = "Allow tunnel traffic"
  vpc_id      = var.jnpr_vpc_id

}

resource "aws_security_group_rule" "isakmp" {
  type = "ingress"
  from_port = 500
  to_port = 500
  protocol = "udp"
  security_group_id = aws_security_group.ge-000.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipsec-nat" {
  type = "ingress"
  from_port = 4500
  to_port = 4500
  protocol = "udp"
  security_group_id = aws_security_group.ge-000.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "esp" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = 50
  security_group_id = aws_security_group.ge-000.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ah" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = 51
  security_group_id = aws_security_group.ge-000.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ge000-out" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.ge-000.id
  cidr_blocks = ["0.0.0.0/0"]
}
