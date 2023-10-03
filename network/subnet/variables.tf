variable "name" {
  description = "Name of resource."
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resource in."
}

variable "virtual_network_name" {
  description = "virtual_network_name to deploy resource in."
}

variable "network_security_group_id" {
  description = "(optional) network securiy group id to associate with this subnet."
  type        = string
  default     = "" # none
}

variable "address_prefixes" {
  description = "CIDR(s) of subnet. e.g. 10.0.1.0/24"
  default     = ["10.0.1.0/24"]
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet. Default valule is false. Conflicts with enforce_private_link_service_network_policies.  See https://www.terraform.io/docs/providers/azurerm/r/subnet.html#enforce_private_link_endpoint_network_policies"
  default     = false
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link service on the subnet. Default valule is false. Conflicts with enforce_private_link_endpoint_network_policies.  See https://www.terraform.io/docs/providers/azurerm/r/subnet.html#enforce_private_link_service_network_policies"
  default     = false
}

variable "service_endpoints" {
  description = "list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory. See https://www.terraform.io/docs/providers/azurerm/r/subnet.html#service_endpoints"
  default     = []
  type        = list(string)
}

variable "delegations" {
  description = "list of delegations to associate with the subnet.See https://www.terraform.io/docs/providers/azurerm/r/subnet.html#delegation"
  type        = map(map(string))
  default     = {}
  # example for databricks https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-inject
  #{anykey = {
  #  name = "Microsoft.Databricks/workspaces"
  #  actions = "Microsoft.Network/networkinterfaces/*
  #}}
}