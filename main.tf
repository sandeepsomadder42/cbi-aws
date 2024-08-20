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

resource "aws_instance" "myserver" {
  ami           = "ami-0c0e147c706360bd7"
  instance_type = "t3.micro"
vpc_security_group_ids = ["sg-0e00b2fb90a15b83d"]
  tags = {
    Name = "SampleServer"
  }
}

# Add a 1 GB EBS volume of type gp3
resource "aws_ebs_volume" "my_volume" {
  availability_zone = aws_instance.myserver.availability_zone
  size              = 1
  type              = "gp3"

  tags = {
    Name = "MyVolume"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"  # Choose an appropriate device name
  volume_id   = aws_ebs_volume.my_volume.id
  instance_id = aws_instance.myserver.id
}

  

