resource "aws_route_table" "bullfrig_prt_2a" {
  vpc_id = aws_vpc.bullfrig.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.bull.id
  }

  tags = {
    Name = "Bullfrig Private RT_APP"
    Environment = "Prod"
  }
}

resource "aws_route_table_association" "app" {
    subnet_id = aws_subnet.app.id
    route_table_id = aws_route_table.bullfrig_prt_2a.id
}

resource "aws_route_table" "bullfrig_prt_2b" {
  vpc_id = aws_vpc.bullfrig.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.bull1.id
  }

  tags = {
    Name = "Bullfrig Private RT_APP1"
    Environment = "Prod"
  }
}

resource "aws_route_table_association" "app1" {
    subnet_id = aws_subnet.app1.id
    route_table_id = aws_route_table.bullfrig_prt_2b.id
}