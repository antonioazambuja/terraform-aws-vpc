resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  vpc      = true
  tags     = var.eip_nat_tags
}