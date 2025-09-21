

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

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)
  vpc_id   = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  tags = { Name = "${var.vpc_name}-public-${each.key}" }
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)
  vpc_id   = aws_vpc.this.id
  cidr_block = each.value
  tags = { Name = "${var.vpc_name}-private-${each.key}" }
}