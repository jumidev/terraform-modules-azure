variable "name" {
  description = "Name of dns zone.  e.g. myzone.example.com"
}

variable "location" {

}

variable "tags" {
  default = {}
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}


variable "rspath_virtual_network" {
  description = "Remote state key of virtual network to deploy in."
  type        = string
}

variable "rspath_public_subnet" {
  description = "Remote state key of public subnet to deploy in."
  type        = string
}

variable "rspath_private_subnet" {
  description = "Remote state keyof private subnet to deploy in."
  type        = string
}

variable "sku" {
  default = "standard"
}

variable "no_public_ip" {
  description = "Are public IP Addresses not allowed? Default False"
  default     = false
}
