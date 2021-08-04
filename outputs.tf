output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_id" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "public_subnets_arn" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "aws_internet_gateway_arn" {
  value = aws_internet_gateway.main.arn
}

output "aws_route_table_igw_ids" {
  value = [for rt in aws_route_table.igw : rt.id]
}

output "aws_route_table_igw_arn" {
  value = [for rt in aws_route_table.igw : rt.arn]
}

output "aws_route_table_association_igw_association_ids" {
  value = [for rta in aws_route_table_association.igw : rta.id]
}

output "private_subnets_id" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "private_subnets_arn" {
  value = [for subnet in aws_subnet.private : subnet.arn]
}

output "nat_gateway_ids" {
  value = [for nat_gateway in aws_nat_gateway.nat_gateway : nat_gateway.id]
}

output "aws_route_table_nat_ids" {
  value = [for rt in aws_route_table.nat : rt.id]
}

output "aws_route_table_nat_arns" {
  value = [for rt in aws_route_table.nat : rt.arn]
}

output "aws_route_table_association_nat_association_id" {
  value = [for rta in aws_route_table_association.nat : rta.id]
}