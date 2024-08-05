terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.0"
   }
 }
}

provider "aws" {
  region = var.us_east_region
}

provider "aws" {
  alias  = "failove-region"
  region = var.us_west_region
}
