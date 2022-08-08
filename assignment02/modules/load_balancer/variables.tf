variable "rg" {
  default = ""
}
variable "location" {
  default = ""
}

variable "public_ip_address_id" {
  default = ""
}

variable "linux_nic" {

    default = null 
}


variable "network_interface_id" {
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

