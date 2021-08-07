resource "aws_route_table" "nat" {
  for_each = aws_nat_gateway.nat_gateway
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }

  tags = var.rt_nat_tags
}

resource "aws_route_table_association" "nat" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = length(aws_subnet.public) < length(aws_subnet.private) ? aws_route_table.nat[index(local.azs, random_integer.az.result)].id : aws_route_table.nat[each.key].id
}

resource "aws_route_table" "igw" {
  for_each = aws_subnet.public
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = var.rt_igw_tags
}

resource "aws_route_table_association" "igw" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.igw[each.key].id
}