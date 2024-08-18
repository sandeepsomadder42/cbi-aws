terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "eu-east-1a"  # Replace with your actual region
}

resource "aws_instance" "dev_ops_windows" {
  ami           = "ami-07d9456e59793a7d5"  # Replace with a valid Windows AMI ID for your region
  instance_type = "t2.micro"               # Choose the instance type based on your needs

  subnet_id              = aws_subnet.private_subnet_1b.id
  vpc_security_group_ids = [aws_security_group.windows_rdp.id]

  key_name                   = "Windowskey.pem"         # Replace with your actual PEM key name
  associate_public_ip_address = true                    # Attach a public IP address

  tags = {
    Name = "dev-ops-windows-instance"
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-east-1b"  # Replace with your actual availability zone
  tags = {
    Name = "private-subnet-1b"
  }
}

resource "aws_security_group" "windows_rdp" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "windows-RDP"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "windows-RDP"
  }
}
