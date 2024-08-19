terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "decommission" { 
 count = 0 
 instance_id = "i-01a024e54fedf96f5"
 }  

  

