locals {
  azs = keys(aws_subnet.public)
}

resource "random_shuffle" "public_az" {
  input = keys(aws_subnet.public)
  keepers = {
    length = length(local.azs)
  }
}