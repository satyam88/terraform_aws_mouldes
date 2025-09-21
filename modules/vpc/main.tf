# Fetch available AZs dynamically
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.vpc_name}-igw" }
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : cidr => idx }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.key
  availability_zone       = data.aws_availability_zones.available.names[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${each.key}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : cidr => idx }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.available.names[each.value]

  tags = {
    Name = "${var.vpc_name}-private-${each.key}"
  }
}

# Export Subnet IDs for use in other modules
output "private_subnets_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_subnets_ids" {
  value = [for s in aws_subnet.public : s.id]
}