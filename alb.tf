# Create ALB
resource "aws_lb" "sonar_web_alb" {
  name               = "sonar-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sonar_alb_sg.id]
  subnets            = [for i in aws_subnet.public_subnets : i.id]
}

resource "aws_lb_target_group" "target_group" {
  name     = "sonar-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sonar_vpc.id


  health_check {
    path     = "/"
    matcher  = 200
  }
}

# Create listener rule
resource "aws_lb_listener" "sonar_alb_listener" {
  load_balancer_arn   = aws_lb.sonar_web_alb.arn
  port                = 80
  protocol            = "HTTP"


  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.target_group.arn
  }
}
