variable "name" {
  description = "Name of dns record.  e.g. myapp"
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}

variable "rspath_dns_zone" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}

variable "ttl" {
  description = "TTL of record, in seconds, default is 300"
  default     = 300
}

variable "record" {
  description = "optional CNAME record to point to (conflicts with target_resource_id)"
  type        = string
  default     = ""
}

variable "target_resource_id" {
  description = "optional Azure resource ID to point to (conflicts with record)"
  type        = string
  default     = ""
}