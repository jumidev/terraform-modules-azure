variable "name" {
  description = "Name of resource group to deploy resources in."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  default     = "Standard"
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  default     = "Static"
}

variable "domain_name_label" {
  description = "Label for the Domain Name. Will be used to make up the FQDN."
  default     = null
  type        = string
}

variable "reverse_fqdn" {
  description = "A fully qualified domain name that resolves to this public IP address."
  default     = null
  type        = string
}
