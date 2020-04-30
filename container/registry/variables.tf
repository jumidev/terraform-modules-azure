variable "name" {
  description = "Name of resource group to deploy resources in."
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium."
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
