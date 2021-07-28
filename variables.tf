variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC."
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = false
}

variable "vpc_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
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

variable "subnet_tags" {
  description = "A map of tags to assign to the resource."
  type        = map()
  default     = {}
}

variable "igw_tags" {
  description = "A map of tags to assign to the resource."
  type        = map()
  default     = {}
  validation {
    condition     = length(var.igw_tags) > 0
    error_message = "Tags from Internet Gateway is empty."
  }
}