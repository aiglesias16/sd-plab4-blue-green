resource "aws_eip" "this" {
  domain = "vpc"
  tags = merge({
    Name = "eip-nat-${var.subnet_id}"
  }, var.tags)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.subnet_id

  tags = merge({
    Name = "natgw-${var.subnet_id}"
  }, var.tags)
}
