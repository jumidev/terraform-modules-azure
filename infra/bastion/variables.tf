variable "name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Location to deploy resources in."
}

variable "rspath_subnet" {
  description = "Remote state key of the subnet (name must be AzureBastionSubnet)."
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
