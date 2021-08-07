resource "aws_subnet" "private" {
  for_each          = { for private_subnet in var.private_subnets: private_subnet.availability_zone => private_subnet }
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = cidrsubnet(var.cidr_block, each.value.newbits, index(var.private_subnets, each.value)+1)
  tags              = var.private_subnet_tags
}

resource "aws_subnet" "public" {
  for_each          = { for public_subnet in var.public_subnets: public_subnet.availability_zone => public_subnet }
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = cidrsubnet(var.cidr_block, each.value.newbits, index(var.public_subnets, each.value))
  tags              = var.public_subnet_tags
}