
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "selected" {
  id ="sg-0049eb92d164f56ae"
}

resource "aws_instance" "app_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name 	    = "keyforlab"
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  associate_public_ip_address = true
  user_data = file("userdata.sh")

  tags = {
    Name = "aws_lab"
  }
}