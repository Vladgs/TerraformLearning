provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

data "aws_ami" "latest_windows_2022" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

output "latest_windows_2022_id" {
  value = data.aws_ami.latest_windows_2022.id
}

output "latest_windows_2022_name" {
  value = data.aws_ami.latest_windows_2022.name
}

output "Latest_amazon_linux_Ami_Id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "Latest_amazon_linux_ami_name" {
  value = data.aws_ami.latest_amazon_linux.name
}

output "Latest_Ubuntu_Ami_Id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "Latest_Ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}