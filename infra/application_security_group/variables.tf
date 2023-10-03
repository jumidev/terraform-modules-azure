variable "name" {
  description = "Name of resource."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}
