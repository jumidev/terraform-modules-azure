variable "name" {
  description = "Name of resource group to deploy resources in."
}

# variable "tags" {
#   description = "Tags to apply to all resources created."
#   type        = map(string)
#   default     = {}
# }

variable "role_assignments" {
  description = "Remote state key of resource group to deploy resources in."
  type        = map(map(any))
  default     = {}
}

