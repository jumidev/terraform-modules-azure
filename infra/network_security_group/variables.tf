variable "name" {
  description = "Name of resource."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "rspath_resource_group" {
  description = "Remote state key of resource group to deploy resources in."
}

variable "rskey_application_security_groups" {
  description = "Optional list of source application security group remote state paths."
  default     = []
}

variable "security_rules" {
  # see https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html#security_rule
  description = "Map of security rules."
  type        = map(map(any))
  default = {
    "example-open-security-rule" = {
      priority                   = 100       # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
      direction                  = "Inbound" # The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
      access                     = "Allow"   # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
      protocol                   = "*"       # (Required) Network protocol this rule applies to. Can be Tcp, Udp, Icmp, or * to match all.
      source_port_range          = "*"       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any
      destination_port_range     = "*"       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any
      source_address_prefix      = "*"       # CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used
      destination_address_prefix = "*"       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used
  } }

}