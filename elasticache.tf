# Create Elasticcache Security Group

resource "aws_security_group" "bull_ec_sg" {
  name        = "Bullfrig EC SG"
  vpc_id      = aws_vpc.bullfrig.id

  ingress {
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    security_group   = [aws_security_group.bull_asg_sg.id]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bullfrig Elasticache SG"
    Environment = "Prod"
  }
}


# Create Elasticcache Subnet Group 

resource "aws_db_subnet_group" "bull_ec_subnet" {
  name       = "bull_ec_subnet"
  subnet_ids = [
      aws_subnet.app.id,
      aws_subnet.app1.id
      ]

  tags = {
    Name = "BullfrigDB subnet group"
    Environment = "Prod"
  }
}

# Create Elasticcache Replication Group

resource "aws_elasticache_replication_group" "bull_ec_rg" {
  automatic_failover_enabled    = true
  availability_zones            = ["us-east-2a", "us-east-2b"]
  replication_group_id          = "bull-replication-group"
  replication_group_description = "bull-elasticache-replication-group"
  node_type                     = "cache.t2.micro"
  number_cache_clusters         = 2
  engine_version                = "5.0.4"
  parameter_group_name          = "default.redis5.0"
  port                          = 6379
  subnet_group_name             = aws_db_subnet_group.bull_ec_subnet.name
  security_group_ids            =  [
      aws_security_group.bull_ec_sg.id
  ]
  tags = {
      Name = "Bullfrig Elasticache Rep Group"
      Environment = "Prod"
  }
}





