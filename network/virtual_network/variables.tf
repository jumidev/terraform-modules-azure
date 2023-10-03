variable "name" {
  description = "Name of virtual network."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "address_spaces" {
  description = "List of CIDRs for this network, default is 10.0.0.0/16."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}