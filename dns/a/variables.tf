variable "name" {
  description = "Name of dns zone.  e.g. myzone.example.com"
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}

variable "rspath_dns_zone" {
  description = "Remote state key of resource group to deploy resources in."
  type        = string
}

variable "rspath_network_interface_private_ip" {
  description = "Network interface whose private ip to point to."
  default     = ""
  type        = string
}

variable "rspath_network_interface_public_ip" {
  description = "Network interface whose public ip to point to."
  default     = ""
  type        = string
}

variable "ip" {
  description = "IP of A record"
  type        = string
  default = ""
}

variable "ttl" {
  description = "TTL of record, in seconds, default is 300"
  default     = 300
}
