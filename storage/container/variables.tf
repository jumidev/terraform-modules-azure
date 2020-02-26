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

variable "access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  type        = number
  default     = 31
}

variable "network_rules" {
  description = "Network rules restricing access to the storage account."
  type        = object({ ip_rules = list(string), subnet_ids = list(string), bypass = list(string) })
  default     = null
}

variable "events" {
  description = "List of event subscriptions. See documentation for format description."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
