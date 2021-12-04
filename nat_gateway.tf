#Create EIP
resource "aws_eip" "bull" {
 
}

resource "aws_eip" "bull1" {
  
}



resource "aws_nat_gateway" "bull" {
  allocation_id = aws_eip.bull.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "Bullfrig NAT"
    Environment = "Prod"
  }
}
resource "aws_nat_gateway" "bull1" {
  allocation_id = aws_eip.bull1.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "Bullfrig NAT1"
    Environment = "Prod"
  }
}