resource "aws_key_pair" "my_key" {
  key_name   = "myapp-key"
  public_key = file(var.public_key_location)
  
}