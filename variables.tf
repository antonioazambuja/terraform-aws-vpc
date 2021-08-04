variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.vpc_tags) > 0
    error_message = "VPC Tags is empty."
  }
}

variable "public_subnets" {
  description = "A public subnets definition."
  type        = list(object({
    name     = string
    new_bits = number
  }))
  default = []
}

variable "public_subnet_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.public_subnet_tags) > 0
    error_message = "Tags from Public Subnet is empty."
  }
}

variable "igw_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.igw_tags) > 0
    error_message = "Tags from Internet Gateway is empty."
  }
}

variable "rt_igw_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.rt_igw_tags) > 0
    error_message = "Tags from Route Table Internet Gateway is empty."
  }
}

variable "private_subnets" {
  description = "A private subnets definition."
  type        = list(object({
    name     = string
    new_bits = number
  }))
  default = []
}

variable "private_subnet_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.private_subnet_tags) > 0
    error_message = "Tags from Private Subnet is empty."
  }
}

variable "eip_nat_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.eip_nat_tags) > 0
    error_message = "Tags from EIP for NAT Gateway is empty."
  }
}

variable "nat_gateway_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.nat_gateway_tags) > 0
    error_message = "Tags from NAT Gateway is empty."
  }
}

variable "rt_nat_tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
  validation {
    condition     = length(var.rt_nat_tags) > 0
    error_message = "Tags from Route Table NAT Gateway is empty."
  }
}