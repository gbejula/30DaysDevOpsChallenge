output "ec2-ip" {
  value = aws_instance.web-server.public_ip
}