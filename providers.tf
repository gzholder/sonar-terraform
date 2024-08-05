terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.0"
   }
 }
}

provider "aws" {
  region = "us-east-1"
}
provider "aws" {
  alias  = "us_east_2_Ohio"
  region = "us-east-2"
}
