variable "name" {
  description = "Name of server"
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}

variable "sku_name" {
  description = "Required sku_name of the server, see https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-azure-cli#create-an-azure-database-for-postgresql-server"
  default     = "B_Gen5_2"
}

variable "storage_mb" {
  description = "Required storage size, in MB"
  default     = 5120
}

variable "backup_retention_days" {
  description = "Required number of days to retain backups"
  default     = 7
}

variable "geo_redundant_backup" {
  description = "Should backups be geo redundant (default Disabled)"
  default     = "Disabled"
}

variable "auto_grow" {
  description = "Should storage auto grow ? (default Enabled)"
  default     = "Enabled"
}

variable "administrator_login" {
  description = "Admin username"
  default     = "postgresql_admin"
  type        = string
}

variable "administrator_password" {
  description = "Admin password, if none provided, a random one will be generated"
  default     = ""
  type        = string
}

variable "postgresql_version" {
  description = "Which version of postgresql to deploy?  Possible values: 9.5, 9.6, 10, 10.0, and 11, default: 11"
  default     = "11"
  type        = string
}

variable "ssl_enforcement" {
  description = "Should SSL be enforced? (default Enabled)"
  default     = "Enabled"
  type        = string
}
 