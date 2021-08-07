resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  tags                 = var.vpc_tags
}