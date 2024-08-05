# ALB Security Group Setup

resource "aws_security_group" "sonar_alb_sg" {
  name         = local.alb_security_group_name
  description  = "ALB SG"
  vpc_id       = aws_vpc.sonar_vpc.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = local.alb_security_group_name
  }
}

# Autoscaling Security Group from ALB to EC2 instances
resource "aws_security_group" "auto_scale_sg" {
  name        = local.auto_scale_sg_name
  description = "Auto Scaling SG"
  vpc_id      = aws_vpc.sonar_vpc.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sonar_alb_sg.id]
  }
 
  ingress {
    description     = "SSh from me"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.auto_scale_sg_name
  }
}
