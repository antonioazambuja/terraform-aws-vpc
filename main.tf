resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  tags                 = var.vpc_tags
}

module "public_subnets" {
  source          = "hashicorp/subnets/cidr"
  version         = "1.0.0"
  base_cidr_block = var.cidr_block
  networks        = var.public_subnets
}

resource "aws_subnet" "public" {
  for_each          = module.public_subnets.network_cidr_blocks
  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = each.value
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

module "private_subnets" {
  source          = "hashicorp/subnets/cidr"
  version         = "1.0.0"
  base_cidr_block = element(module.public_subnets.networks[*].cidr_block, length(module.public_subnets.networks[*].cidr_block)-1)
  networks        = var.private_subnets
}

resource "aws_subnet" "private" {
  for_each          = module.private_subnets.network_cidr_blocks
  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = each.value
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
  for_each   = aws_subnet.private
  vpc_id     = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[each.key].id
  }

  tags = var.rt_nat_tags
}

resource "aws_route_table_association" "nat" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.nat[each.key].id
}