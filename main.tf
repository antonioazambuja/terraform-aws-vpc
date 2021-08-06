resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  tags                 = var.vpc_tags
}

resource "aws_subnet" "public" {
  for_each          = { for public_subnet in var.public_subnets: public_subnet.availability_zone => public_subnet }
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = cidrsubnet(var.cidr_block, each.value.newbits, index(var.public_subnets, each.value))
  tags              = var.public_subnet_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = var.igw_tags
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

resource "aws_subnet" "private" {
  for_each          = { for private_subnet in var.private_subnets: private_subnet.availability_zone => private_subnet }
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = cidrsubnet(var.cidr_block, each.value.newbits, index(var.private_subnets, each.value)+1)
  tags              = var.private_subnet_tags
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  vpc      = true
  tags     = var.eip_nat_tags
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each      = aws_subnet.public
  subnet_id     = each.value.id
  allocation_id = aws_eip.nat[each.key].id
  tags          = var.nat_gateway_tags
}

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
  route_table_id = aws_route_table.nat[each.key].id
}