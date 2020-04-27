variable "name" {
  description = "Name of storage account, if it contains illigal characters (,-_ etc) those will be truncated."
}

variable "randomize_suffix" {
  description = "Whether the account name should have a random suffix, this can come in handy to easily guarantee that the account name is unique, since it must be globally unique."
  default     = true
}

variable "rspath_subnets" {
  description = "One or more subnets to connect this storage account to."
  default     = []
  type        = list(string)
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "account_kind" {
  description = "Defines the kind to use for this storage account. Valid options BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created."
  default     = "StorageV2"
}

variable "is_hns_enabled" {
  description = "Defines if Hierarchical Namespace (Data Lake) is enabled. Changing this forces a new resource to be created."
  default     = false
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
  default     = "ZRS"
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

# variable "network_rules" {
#   description = "Network rules restricing access to the storage account."
#   type        = object({ ip_rules = list(string), subnet_ids = list(string), bypass = list(string) })
#   default     = null
# }

variable "authorized_cidrs" {
  description = "List of CIDRs allowed to connect to this account to."
  default     = []
  type        = list(string)
}


variable "bypass" {
  description = "(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices"
  default     = ["AzureServices"]
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
