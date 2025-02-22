provider "aws" {
    region = var.region
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [data.aws_security_group.default.id]

  key_name = aws_key_pair.my_key.key_name

  tags = {
    Name = "NCAAServer"
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
