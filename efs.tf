# Create EFS Security Group

resource "aws_security_group" "bull_efs_sg" {
  name        = "Bullfrig EFS Security Group"
  vpc_id      = aws_vpc.bullfrig.id

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups  = [aws_security_group.bull_asg_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "Bullfrig Security Group"
    Environment = "Prod"
  }
}


# Create EFS

resource "aws_efs_file_system" "bull_efs" {   
  creation_token = "bull-elastic-file-system"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"

  tags = {
    Name = "Bullfrig EFS"
    Environment = "Prod"
  }
}

# Create EFS Mount Targets

resource "aws_efs_mount_target" "bull_mt_app" {
  file_system_id = aws_efs_file_system.bull_efs.id
  subnet_id      = aws_subnet.app.id
  security_groups = [
      aws_security_group.bull_efs_sg.id
  ]
}

resource "aws_efs_mount_target" "bull_mt_app1" {
  file_system_id = aws_efs_file_system.bull_efs.id
  subnet_id      = aws_subnet.app1.id
  security_groups = [
      aws_security_group.bull_efs_sg.id
  ]
}
