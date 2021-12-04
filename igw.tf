resource "aws_internet_gateway" "bullfrig_gw" {
  vpc_id = aws_vpc.bullfrig.id

  tags = {
    Name = "Bullfrig IGW"
    Environment = "Prod"
  }
}