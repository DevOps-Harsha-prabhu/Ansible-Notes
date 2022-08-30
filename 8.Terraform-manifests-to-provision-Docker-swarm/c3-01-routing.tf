# public routing table
resource "aws_route_table" "public-routing-table" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-RT"
    Deployed_by = local.Deployed_by
    owner       = local.owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"

  }
}

resource "aws_route_table_association" "public-subnets" {
  #count         = 3
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index) # splat operator or splat syntax. 
  route_table_id = aws_route_table.public-routing-table.id
}

# private routing table 
resource "aws_route_table" "private-routing-table" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.vpc_name}-private-RT"
    Deployed_by = local.Deployed_by
    owner       = local.owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"

  }
}

resource "aws_route_table_association" "private-subnets" {
  #count         = 3
  count          = length(var.private_cidr_block)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index) # splat operator or splat syntax. 
  route_table_id = aws_route_table.private-routing-table.id
}
