resource "aws_nat_gateway" "nat_gateway" {
  for_each      = aws_subnet.public
  subnet_id     = each.value.id
  allocation_id = aws_eip.nat[each.key].id
  tags          = var.nat_gateway_tags
}