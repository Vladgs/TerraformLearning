# 
# My Terraform
# 
# Build Web Server during Bootstap
#
# Made by Vlad

provider "aws" {

region = "eu-central-1"
  
}

resource "aws_instance" "MyWebServer" {
  ami = "ami-06c39ed6b42908a36" # Amazon Linux AMI
  instance_type = "t2.micro"
  tags = {
    Name = "My_Web_Server"
    Owner = "Vlad"
    Project = "Terraform_Lesson_2"
  }

vpc_security_group_ids = [aws_security_group.MyWebServer.id]

user_data = templatefile("user_data.sh", {
  f_name = "Vlad",
  l_name = "Test",
  names = ["Michael", "Peter", "John", "Steven", "Donald", "Maria"]
})

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

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_for_WebServer_Lesson_2"
  }
}