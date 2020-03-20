variable "name" {
  description = "Name of dns zone.  e.g. myzone.example.com"
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