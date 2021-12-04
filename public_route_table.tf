resource "aws_route_table" "bullfrig_pub_2a" {
  vpc_id = aws_vpc.bullfrig.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bullfrig_gw.id
  }

  tags = {
    Name = "Bullfrig Public Route Table"
    Environment = "Prod"
  }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.bullfrig_pub_2a.id
}



resource "aws_route_table" "bullfrig_pub_2b" {
  vpc_id = aws_vpc.bullfrig.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bullfrig_gw.id
  }

  tags = {
    Name = "Bullfrig Public Route Table"
    Environment = "Prod"
  }
}

resource "aws_route_table_association" "public1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.bullfrig_pub_2b.id
}