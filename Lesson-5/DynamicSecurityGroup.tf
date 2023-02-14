# 
# My Terraform
# 
# Learning Dynamic Blocks
#
# Made by Vlad

provider "aws" {

region = "eu-central-1"
  
}

resource "aws_security_group" "Dynamic_SG" {
  name        = "Dynamic_Security_Group"
  description = "Test_Dyn_SG"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092", "9093", "5678"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic_SG_Lesson_5"
  }
}