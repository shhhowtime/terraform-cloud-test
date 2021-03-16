provider "aws" {
  region = "eu-central-1"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
  
  root_device_name = "/dev/xvda"

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 4
  }
}

resource "aws_instance" "netpology_fmarkov" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "Fyodor Markov for Netology homework"
  }
}

