resource "aws_lb_target_group" "bull_front_end_tg" {
  name     = "bullfrig-front-end-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.bullfrig.id
  stickiness {
      type = "lb_cookie"
      enabled = true
  }
  health_check {
      protocol ="HTTP"
      path = "/healthy.html"
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      interval = 15
  }

  tags = {
      Name = "Bullfrig Front End Target Group"
      Environment = "Prod"
  }
}


resource "aws_lb_target_group" "bull_back_end_tg" {
  name     = "bullfrig-back-end-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.bullfrig.id
  stickiness {
      type = "lb_cookie"
      enabled = true
  }
  health_check {
      protocol ="HTTP"
      path = "/healthy.html"
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      interval = 10
  }

  tags = {
      Name = "Bullfrig Back End Target Group"
      Environment = "Prod"
  }
}
