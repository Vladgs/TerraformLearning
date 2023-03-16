#------------------------------------------------------------------------------------
# Terraform Lesson-23
# 
# Global Variables in Remote State on the S3
# 
# Made by Vlad
#------------------------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "vladgs"
    key    = "globalvars/terraform.tfstate"
    region = "eu-central-1"
  }
}

#==========================================================

output "company_name" {
  value = "CompanyXYZ"
}

output "owner" {
  value = "Vlad"
}

output "tags" {
  value = {
    Project    = "IPO2022"
    CostCenter = "R&D"
    Country    = "Germany"
  }
}