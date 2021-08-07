locals {
  azs = keys(aws_subnet.private)
}

resource "random_integer" "az" {
  min = 0
  max = length({ for public_subnet in var.public_subnets: public_subnet.availability_zone => public_subnet }) - 1
}