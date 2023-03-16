#------------------------
#Terraform learning------
#------------------------
#Lesson-14---------------
#------------------------
#Local Variables---------

provider "aws" {
  region = "eu-central-1"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  full_project_name = "${var.enviroment} - ${var.project_name}"
  project_owner     = "${var.owner} is owner of ${var.project_name}"
  az_list           = join(",", data.aws_availability_zones.available.names)
  region            = data.aws_region.current.description
  location          = "In ${local.region} there are AZs ${local.az_list}"
}

resource "aws_eip" "my_static_ip" {
  tags = {
    name          = "Static IP"
    owner         = var.owner
    project_owner = local.project_owner
    project       = local.full_project_name
    region_azs    = local.az_list
    location      = local.location
  }
}