#----------------------------------------------------------
# Terraform Lesson-19
#
# Provision Resources in Multiply AWS Regions / Accounts
#
# Made by Vlad
#----------------------------------------------------------

provider "aws" {
    region = "eu-central-1"
}

provider "aws" {
    region = "ca-central-1"
    alias = "CA"
}

provider "aws" {
    region = "us-east-1"
    alias = "USA"
}

data "aws_ami" "latest_amazon_linux" {
  owners = [ "amazon" ]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

data "aws_ami" "latest_amazon_linux_CA" {
  provider = aws.CA
  owners = [ "amazon" ]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

data "aws_ami" "latest_amazon_linux_USA" {
  provider = aws.USA
  owners = [ "amazon" ]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

resource "aws_instance" "my_ger_server" {
    ami = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
    tags = {
      Name = "My Server in Germany"
    }
}

resource "aws_instance" "my_ca_server" {
    provider = aws.CA
    ami = data.aws_ami.latest_amazon_linux_CA.id
    instance_type = "t2.micro"
    tags = {
      Name = "My Server in Canada"
    }
}

resource "aws_instance" "my_usa_server" {
    provider = aws.USA
    ami = data.aws_ami.latest_amazon_linux_USA.id
    instance_type = "t2.micro"
    tags = {
      Name = "My Server in USA"
    }
}