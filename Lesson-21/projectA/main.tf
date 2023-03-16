#------------------------------------------------------------------------------------
# Terraform Lesson-22
# Provision ressources from modules
# - VPC
# - Internet Gateway
# - XX Public Subnets
# - XX Privat Subnets
# - XX NAT Gateways in Public Subntes to give access to Internet from Private Subnets
# 
# Made by Vlad
#------------------------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

/*module "vpc-default" {
    source = "../modules/aws_network"
}*/

module "vpc-dev" {
  // source = "../modules/aws_network"
  source   = "git@github.com:Vladgs/terraform-modules.git//aws_network"
  env      = "dev"
  vpc_cidr = "10.100.0.0/16"
  public_subnet_cidrs = [
  "10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = []
}

module "vpc-prod" {
  // source = "../modules/aws_network"
  source   = "git@github.com:Vladgs/terraform-modules.git//aws_network"
  env      = "prod"
  vpc_cidr = "10.10.0.0/16"
  public_subnet_cidrs = [
  "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnet_cidrs = [
  "10.10.11.0/24", "10.10.22.0/24", "10.10.33.0/24"]
}

module "vpc-test" {
  //source = "../modules/aws_network"
  source   = "git@github.com:Vladgs/terraform-modules.git//aws_network"
  env      = "staging"
  vpc_cidr = "10.10.0.0/16"
  public_subnet_cidrs = [
  "10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_cidrs = [
  "10.10.11.0/24", "10.10.22.0/24"]
}

#====================================================================================

output "prod_public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}

output "dev_public_subnet_ids" {
  value = module.vpc-dev.public_subnet_ids
}

output "dev_private_subnet_ids" {
  value = module.vpc-dev.private_subnet_ids
}