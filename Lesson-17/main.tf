#----------------------------------------------------------
# Terraform Lessons-17
#
# Terraform Conditions and Lookups
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

variable "env" {
    default = "dev"
}

variable "prod_owner" {
    default = "Vlad"
}

variable "noprod_owner" {
    default = "Dydya Vasya"
}

variable "ec2_size" {
    default = {
        "prod" = "t3.medium"
        "dev" = "t3.micro"
        "staging" = "t3.small"
    }
  
}

variable "allow_port_list" {
    default = {
        "prod" = ["80", "443"]
        "dev" = ["80", "443", "8080", "22"]
    }
  
}

resource "aws_instance" "my_server" {
    ami = data.aws_ami.latest_amazon_linux.id
    //instance_type = var.env == "prod" ? "t2.large" : "t2.micro"
    instance_type = var.env == "prod" ? var.ec2_size["prod"] : "t2.micro"
    tags = {
        Name = "${var.env} - server"
        Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner

    }
}

resource "aws_instance" "my_server2" {
    ami = data.aws_ami.latest_amazon_linux.id
    instance_type = lookup(var.ec2_size, var.env) 
    tags = {
        Name = "${var.env} - server"
        Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner

    }
}

resource "aws_instance" "my_dev_bastion" {
    count = var.env == "dev" ? 1 : 0
    ami = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
    tags = {
        Name = "Bastion server for Dev"
    }
}

resource "aws_security_group" "Dynamic_SG" {
  name        = "Dynamic_Security_Group"
  description = "Test_Dyn_SG"

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
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