# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.terraformvpc-public-1.id
  depends_on    = [aws_internet_gateway.terraformvpc-gw]
}

# VPC setup for NAT
resource "aws_route_table" "terraformvpc-private" {
  vpc_id = aws_vpc.terraformvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "terraformvpc-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "terraformvpc-private-1-a" {
  subnet_id      = aws_subnet.terraformvpc-private-1.id
  route_table_id = aws_route_table.terraformvpc-private.id
}

resource "aws_route_table_association" "terraformvpc-private-2-a" {
  subnet_id      = aws_subnet.terraformvpc-private-2.id
  route_table_id = aws_route_table.terraformvpc-private.id
}

resource "aws_route_table_association" "terraformvpc-private-3-a" {
  subnet_id      = aws_subnet.terraformvpc-private-3.id
  route_table_id = aws_route_table.terraformvpc-private.id
}

