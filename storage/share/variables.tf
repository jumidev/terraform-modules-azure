variable "name" {
  description = "Name of share, if it contains illigal characters (,-_ etc) those will be truncated."
}

variable "rspath_storage_account" {
  description = "Remote state key of storage account to deploy container in."
}

variable "quota" {
  description = "Quota in Gigabytes, default 5120"
  default     = 5120
}
