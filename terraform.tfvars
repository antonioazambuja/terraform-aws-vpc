# VPC
cidr_block = "10.51.0.0/16"
vpc_tags   = {
    Name = "MainVPC"
}

# Public Subnets
public_subnets = [
    {
      name     = "us-east-1a"
      new_bits = 8
    },
    {
      name     = "us-east-1b"
      new_bits = 8
    },
    {
      name     = "us-east-1c"
      new_bits = 8
    },
    {
      name     = "us-east-1d"
      new_bits = 8
    },
    {
      name     = "us-east-1e"
      new_bits = 8
    },
]
public_subnet_tags = {
    AccessMode = "PUBLIC"
}

# Internet Gateway
igw_tags = {
    Name = "MainIGW"
}
rt_igw_tags = {
    Name = "MainIGW"
}

# Private Subnets
private_subnets = [
    {
      name     = "us-east-1a"
      new_bits = 5
    },
    {
      name     = "us-east-1b"
      new_bits = 5
    },
    {
      name     = "us-east-1c"
      new_bits = 5
    },
    {
      name     = "us-east-1d"
      new_bits = 5
    },
    {
      name     = "us-east-1e"
      new_bits = 5
    },
]
private_subnet_tags = {
    AccessMode = "PRIVATE"
}

# EIP
eip_nat_tags = {
    Name = "EIPVpc"
}

# NAT Gateway
nat_gateway_tags = {
    Name = "MainNATGateway"
}

rt_nat_tags = {
    Name = "MainNATGateway"
}