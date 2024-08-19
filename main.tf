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

resource "aws_instance" "SampleServer" {
  count = 0  # Setting count to 0 will destroy the instance
  # Additional configuration if necessary
}


  

