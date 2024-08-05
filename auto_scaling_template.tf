# Launch Template and autoscaling resources

resource "aws_launch_template" "autoscale_launch_template" {
  name             = local.launch_template_ec2_name
  image_id         = var.ami
  key_name         = "ec2-2"
  instance_type    = var.instance_type

  network_interfaces {
    device_index     = 0
    security_groups  = [aws_security_group.auto_scale_sg.id]
  }
  tag_specifications {
    resource_type = "instance"
    
    tags = {
      Name = local.launch_template_ec2_name
    }
  }

  user_data = filebase64("${path.module}/apache_setup.sh")
}

# Configure capacity
resource "aws_autoscaling_group" "ec2-auto-scale-group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [for i in aws_subnet.private_subnets[*] : i.id]

  target_group_arns   = [aws_lb_target_group.target_group.arn]

  launch_template {
    id         = aws_launch_template.autoscale_launch_template.id
    version    = aws_launch_template.autoscale_launch_template.latest_version
  }
}
