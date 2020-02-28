variable "name" {
  description = "Name of container, if it contains illigal characters (,-_ etc) those will be truncated."
}

variable "rspath_storage_account" {
  description = "Remote state key of storage account to deploy container in."
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
  default     = "ZRS"
}

variable "access_type" {
  description = "Defines the access type. Valid options are public and private."
  default     = "private"
}

