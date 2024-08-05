output "alb_public_url" {
  description   = "Public URL"
  value         = aws_lb.sonar_web_alb.dns_name
}
