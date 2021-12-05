# Security Group for ALB

resource "aws_security_group" "bull_alb_sg" {
  name        = "ALB Secirity Group"
  vpc_id      = aws_vpc.bullfrig.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "Bullfrig ALB Security Group"
  }
}


# Application Load Balancer

resource "aws_lb" "bull_alb" {
  name               = "Bullfrig-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bull_alb_sg.id]
  subnets            = [ 
      aws_subnet.public.id,
      aws_subnet.public1.id
  ]

  enable_deletion_protection = false

  tags = {
      Name = "Bullfrin ALB"
    Environment = "production"
  }
}