resource "aws_vpc" "test" {
  cidr_block                       = "10.1.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "dev"
  }
}

# comment

resource "aws_subnet" "subnet_a_public" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = "10.1.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = var.availablity_zone
  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "test_internet_gateway" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "dev-gatwy"
  }
}

resource "aws_route_table" "test_table" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "dev-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.test_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_internet_gateway.id
}

resource "aws_route_table_association" "default_association_1" {
  subnet_id      = aws_subnet.subnet_a_public.id
  route_table_id = aws_route_table.test_table.id
}