# Create Security Group

resource "aws_security_group" "bull_rds_sg" {
  name        = "Bullfrig RDS Security Group"
  vpc_id      = aws_vpc.bullfrig.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [
      aws_security_group.bull_asg_sg.id
    ]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Bullfrig RDS_SG"
    Environment = "Prod"
  }
}


# Create DB Subnet

resource "aws_db_subnet_group" "bull_db_sn" {
  name       = "bullfrig-db-subnet"
  subnet_ids = [
      aws_subnet.db.id,
      aws_subnet.db1.id
      ]

  tags = {
    Name = "Bufffrig DB subnet group"
    Environment = "Prod"
  }
}


# Create DB Instance

resource "aws_db_instance" "dfsc-db" {
  allocated_storage       = "10"
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.6"
  multi_az                = "true"
  instance_class          = "db.t2.micro"
  name                    = "magento"
  username                = "Bullfrig"
  password                = var.db_password
  identifier              = "bull-database"
  skip_final_snapshot     = "true"
  backup_retention_period = "7"
  port                    = "3306"
  storage_encrypted       = "false"
  db_subnet_group_name    = aws_db_subnet_group.bull_db_sn.name
  vpc_security_group_ids  = [aws_security_group.bull_rds_sg.id]
   tags = {
    Name        = "Bullfrig Database"
    Environment = "Prod"
  }
}