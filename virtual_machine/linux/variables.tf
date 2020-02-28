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

variable "size" {
  description = "Instance size, see https://azureprice.net/."
  default     = "Standard_B1ls"
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}

variable "rspath_network_interfaces" {
  description = "Remote state key of one or more network interfaces to attach to VM."
  type        = list(string)
}

variable "linux_distribution" {
  description = "OS to use, (debian,ubuntu,centos) image, see `az vm image list`"
  default     = "debian"
}

variable "public_key_file" {
  type = string
}

variable "os_disk_caching" {
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  default = "Standard_LRS"
}

variable "os_disk_write_accelerator_enabled" {
  default = false
}
