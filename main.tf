resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

module "public_subnets" {
  source          = "hashicorp/subnets/cidr"
  version         = "1.0.0"
  base_cidr_block = var.cidr_block
  networks        = var.public_subnets
}

resource "aws_subnet" "public" {
  for_each          = module.public_subnets.networks
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.name
  cidr_block        = each.value.cidr_block
  tags              = var.subnet_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = var.igw_tags
}

# resource "aws_route_table" "gw" {
#   for_each = aws_subnet.public
#   vpc_id   = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = format("rt-igw-%s","${each.key}")
#   }
# }

# resource "aws_route_table_association" "gw" {
#   for_each       = aws_subnet.public
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.gw[each.key].id
# }

# resource "aws_subnet" "private" {
#   for_each          = { for key, value in var.subnets: key => value if value.private }
#   vpc_id            = aws_vpc.main.id
#   availability_zone = format("%s%s","${var.region}","${each.value.availability_zone}")
#   cidr_block        = each.value.cidr_block

#   tags = {
#     Name       = each.value.name,
#     AccessMode = "PRIVATE"
#   }
# }

# resource "aws_eip" "nat" {
#   for_each = aws_subnet.public
#   vpc      = true

#   tags = {
#     "Name" = format("%s-%s","${var.eip_name}","${each.key}"),
#     "Gateway" = "NAT"
#   }
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   for_each      = aws_subnet.public
#   subnet_id     = each.value.id
#   allocation_id = aws_eip.nat[each.key].id

#   tags = {
#     Name = format("%s-%s","${var.nat_gateway_name}","${each.key}")
#   }

#   depends_on = [aws_internet_gateway.gw]
# }

# resource "aws_route_table" "nat" {
#   for_each   = aws_subnet.private
#   vpc_id     = aws_vpc.main.id
#   depends_on = [aws_nat_gateway.nat_gateway]

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = var.environment != "prd" ? aws_nat_gateway.nat_gateway[0].id : aws_nat_gateway.nat_gateway[each.key].id
#   }

#   route {
#     cidr_block = var.shared_vpc_cidr_block
#     transit_gateway_id = var.aws_ec2_transit_gateway_shared_id
#   }

#   tags = {
#     Name = format("rt-nat-%s","${each.key}")
#   }
# }

# resource "aws_route_table_association" "nat" {
#   for_each       = aws_subnet.private
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.nat[each.key].id
# }