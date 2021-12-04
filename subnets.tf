# Create Subnets

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.bullfrig.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bullfrig Public Subnet"
    Environment = "Prod"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.bullfrig.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bullfrig Public1 Subnet"
    Environment = "Prod"
  }
}


resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.bullfrig.id
  cidr_block = "10.0.112.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bullfrig APP Subnet"
    Environment = "Prod"
  }
}

resource "aws_subnet" "app1" {
  vpc_id     = aws_vpc.bullfrig.id
  cidr_block = "10.0.13.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bullfrig APP1 Subnet"
    Environment = "Prod"
  }
}



resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.bullfrig.id
  cidr_block = "10.0.14.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bullfrig DB Subnet"
    Environment = "Prod"
  }
}

resource "aws_subnet" "db1" {
  vpc_id     = aws_vpc.bullfrig.id
  cidr_block = "10.0.15.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bullfrig DB1 Subnet"
    Environment = "Prod"
  }
}
