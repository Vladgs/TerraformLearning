#----------------------------------------------------------
# Terraform Lesson-18
#
# Terraform Loops: Count and For if
#
# Made by Vlad
#----------------------------------------------------------

provider "aws" {
    region = "eu-central-1"
}

data "aws_ami" "latest_amazon_linux" {
  owners = [ "amazon" ]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

resource "aws_iam_user" "user1" {
    name = "pushkin"
}

resource "aws_iam_user" "users" {
    count = length(var.aws_users)
    name = element(var.aws_users, count.index)
}

#-----------------------------------------------------------------

resource "aws_instance" "servers" {
    count = 3
    ami = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
    tags = {
      Name = "Server number ${count.index + 1}"
    }
}