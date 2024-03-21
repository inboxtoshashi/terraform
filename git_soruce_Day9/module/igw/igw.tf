resource "aws_internet_gateway" "gw" {
  tags = {
    Name = "igw"
  }
  vpc_id = var.vpc_id
}