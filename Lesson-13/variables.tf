variable "region" {
    description = "Please enter AWS region"
    type = string
    default = "eu-central-1"
}

variable "instance_type" {
    description = "Enter instance type"
    type = string
    default = "t2.micro"
}

variable "allow_ports" {
    description = "List of ports to open for server"
    type = list
    default = ["80", "443", "22", "8080"]
}

variable "enable_detailed_monitoring" {
    default = "true"
    type = bool
}

variable "common_tags" {
    description = "Common tags to apply to all resources"
    type = map
    default = {
      Owner = "Vlad"
      Project = "Phoenix"
      CostCenter = "12345"
      Enviroment = "Developmet"
    }
  
}