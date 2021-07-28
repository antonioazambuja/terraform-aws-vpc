output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_id" {
  value = aws_subnet.public[*].id
}

output "public_subnets_arn" {
  value = aws_subnet.public[*].arn
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "aws_internet_gateway_arn" {
  value = aws_internet_gateway.main.arn
}