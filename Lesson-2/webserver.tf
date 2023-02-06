# 
# My Terraform
# 
# Build Web Server during Bootstap
#
# Made by Vlad

provider "AWS" {
  region = "eu-central-1"
}

resource "aws_instance" "MyWebServer" {
  ami = "ami-06c39ed6b42908a36" # Amazon Linux AMI
  instance_type = "t2.micro"
}

resource "aws_security_group" "MyWebServer" {
  name        = "WebServerSG"
  description = "MyFirstSG"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}