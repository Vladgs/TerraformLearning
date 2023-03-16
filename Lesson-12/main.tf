#----------------------------------------------------------
# Variables
#
# Made by Vlad 15.02.2023
#-----------------------------------------------------------

provider "aws" {
  region = var.region
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

resource "aws_eip" "my_static_ip" {
  vpc      = "true"
  instance = aws_instance.my_server.id
  /*tags = {
      Name = "Server_IP"
      Owner = "Vlad"
      Project = "Phoenix"
      Region = var.region
    } */

  tags = merge(var.common_tags, { Name = "${var.common_tags["Enviroment"]} Server IP" })
}

resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  monitoring             = var.enable_detailed_monitoring

  tags = merge(var.common_tags, { Name = "${var.common_tags["Enviroment"]} Server build by Terraform" })
  /* tags = {
      Name = "Server build by Terraform"
      Owner = "Vlad"
      Project = "Phoenix"
    }*/

}

resource "aws_security_group" "my_server" {
  name = "My_SG"

  dynamic "ingress" {
    for_each = var.allow_ports
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

  tags = merge(var.common_tags, { Name = "${var.common_tags["Enviroment"]} Server security group" })
}