#----------------------------------------------------------
# My Terraform
#
# Lesson-8 Dependencies
#
# Made by Vlad
#----------------------------------------------------------


provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-06c39ed6b42908a36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name  = "Server Web"
    Owner = "Vlad"
  }
  depends_on = [
    aws_instance.DB, aws_instance.my_app
  ]
}

resource "aws_instance" "my_app" {
  ami                    = "ami-06c39ed6b42908a36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name  = "Application"
    Owner = "Vlad"
  }
  depends_on = [
    aws_instance.DB
  ]
}

resource "aws_instance" "DB" {
  ami                    = "ami-06c39ed6b42908a36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name  = "DB"
    Owner = "Vlad"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServerSecurityGroup"
  description = "My First SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Vlad"
  }
}
