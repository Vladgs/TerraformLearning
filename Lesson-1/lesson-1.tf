provider "aws" {}

resource "aws_instance" "MyUbuntu" {
  ami = "ami-03e08697c325f02ab"
  instance_type = "t2.micro"

    tags = {
    Name = "My_Ubuntu_Server"
    Owner = "Vlad"
    Project = "Terraform_Lessons"
  }
}

resource "aws_instance" "MyAWS_Linux" {
  ami = "ami-06c39ed6b42908a36"
  instance_type = "t2.micro"

  tags = {
    Name = "My_AWS_Server"
    Owner = "Vlad"
    Project = "Terraform_Lessons"
  }
}