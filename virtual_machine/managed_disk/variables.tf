variable "name" {
  description = "Name of storage account, if it contains illigal characters (,-_ etc) those will be truncated."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}


variable "size" {
  description = "Size of disk, in GB.  Defaults to 30"
  default     = 30
}