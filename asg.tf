#Create Security Group for ASG

resource "aws_security_group" "bull_asg_sg" {
  name        = "ASG Secirity Group"
  vpc_id      = aws_vpc.bullfrig.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [
        aws_security_group.bull_alb_sg.id
    ]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [
        aws_security_group.bull_alb_sg.id
    ]
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

#Create Launch Configuration

resource "aws_launch_configuration" "bull_launch_conf" {
  name_prefix   = "Bullfrig Launch Configuration-"
  image_id      = "ami-0629230e074c580f2"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.bull_asg_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

# Create ASG Front End

resource "aws_autoscaling_group" "bull_asg_front_end" {
  name                      = "Front-end-autoscaling-group"
  launch_configuration      = aws_launch_configuration.bull_launch_conf.name
  max_size                  = 0
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0


  vpc_zone_identifier       = [aws_subnet.app.id, aws_subnet.app1.id]

  target_group_arns = [aws_lb_target_group.bull_front_end_tg.arn]
                       
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "Bullfrig FrontEnd ASG"
    propagate_at_launch = true
  }
}


# Create ASG Back END

resource "aws_autoscaling_group" "bull_asg_back_end" {
  name                      = "Back-end-autoscaling-group"
  launch_configuration      = aws_launch_configuration.bull_launch_conf.name
  max_size                  = 0
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0


  vpc_zone_identifier       = [aws_subnet.app.id, aws_subnet.app1.id]

  target_group_arns = [aws_lb_target_group.bull_back_end_tg.arn]
                       
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "Bullfrig BackEnd ASG"
    propagate_at_launch = true
  }
}