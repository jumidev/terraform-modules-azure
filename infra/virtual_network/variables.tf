variable "name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
}

variable "rspath_private_dns_zones" {
  description = "List of Remote state keys of private dns zones to link to virtual network."
  type        = list(string)
  default     = []
}

variable "address_spaces" {
  description = "List of CIDRs for this network, default is 10.0.0.0/16."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}