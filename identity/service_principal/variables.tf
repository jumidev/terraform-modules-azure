variable "name" {
  description = "Name of resource group to deploy resources in."
}

variable "password_lenght" {
  description = "Length of the password."
  type        = number
  default     = 32
}

variable "end_date_relative" {
  description = "Relative end date of the service principal password."
  type        = string
  default     = "17520h"
}

variable "available_to_other_tenants" {
  description = "Service principal available to other tenants."
  type        = bool
  default     = false
}

variable "oauth2_allow_implicit_flow" {
  description = "Authorize OAuth2 autenfication with service principal."
  type        = bool
  default     = false
}

variable "role_assignments" {
  description = "Remote state key of resource group to deploy resources in."
  type        = map(map(any))
  default     = {}
}
