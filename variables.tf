locals {
  internet_gateway_name           = "sonar-internet-gateway"
  public_route_table_name         = "sonar-public-route-table"
  private_route_table_name        = "sonar-private-route-table"
  nat_gateway_name                = "sonar-nat-gateway"
  alb_security_group_name         = "sonar-web-alb-sg"
  auto_scale_sg_name              = "sonar-web-alb-autoscaling-sg"
  auto_scale_launch_template_name = "sonar-autoscale-launch-template"
  launch_template_ec2_name        = "sonar-asg-ec2"
}

variable "us_east_region" {
    description = "Primary Region"
    type = string
    default = "us-east-1"
}

variable "us_west_region" {
    description = "Backup Region"
    type = string
    default = "us-west-1"
}

variable "vpc_cidr" {
  description  = "VPC cidr"
  type         = string
  default      = "10.1.0.0/16"

}
variable "failover_vpc_cidr" {
  description  = "Failover VPC cidr"
  type         = string
  default      = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "failover_public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
variable "failover_private_subnet_cidrs" {
  description = "Private Subnet CIDR values"
  type        = list(string)
  default     = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
}

variable "failover_public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

variable "failover_private_subnet_cidrs" {
  description = "Private Subnet CIDR values"
  type        = list(string)
  default     = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
}

variable "a_zones" {
  description = "Availability Zones"
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "failover_a_zones" {
  description = "Availability Zones"
  type    = list(string)
  default = ["us-west-1a", "us-west-1b", "us-west-1c"]
}

variable "ami" {
  type         = string
  default      = "ami-0ba9883b710b05ac6"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t1.micro"
}

variable "desired_capacity" {
  description  = "Desired number of EC2 Intsances in the ASG"
  type         = number
  default      = 3
}

variable "max_size" {
  description   = "Max number of EC2 Instances in the ASG"
  type          = number
  default       = 3
}

variable "min_size" {
  description   = "Minimum number of EC2 Instances in the ASG"
  type          = number
  default       = 1
}

variable "s3_bucket_name" {
  description   = "Bucket name for S3"
  type          = list(string)
  default       = ["basic-bucket-20", "basic-bucket-30"]
}
