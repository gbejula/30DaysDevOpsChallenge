data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = data.aws_security_group.default.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]  # Allows SSH from anywhere (change for security)
}