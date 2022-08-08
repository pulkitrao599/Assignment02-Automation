variable "rg" {
 default = ""
}

variable "location" {
 default = ""
}

locals {

  common_tags = {
    Name      = "Automation Project - Assignment2"
    GroupMembers         = "Pulkit.Rao"
    GroupMembers         = "Chima.Iberi"
    ExpirationDate = "2022-08-21"
    Environment  = "Lab"
  }
}
