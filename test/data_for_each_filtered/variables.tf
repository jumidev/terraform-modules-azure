variable "security_rules" {
  # see https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html#security_rule
  description = "Map of security rules."
  type        = map(map(any))
  default     = {}

  # example = {
  #   "example-allow-all-incoming" = {
  #     priority                          = 100       # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
  #     direction                         = "Inbound" # The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
  #     access                            = "Allow"   # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
  #     protocol                          = "*"       # (Required) Network protocol this rule applies to. Can be Tcp, Udp, Icmp, or * to match all.
  #     source_port_range                 = "*"       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any
  #     destination_port_range            = "*"       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any
  #     source_address_prefix             = "*"       # CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used
  #     destination_address_prefix        = "*"       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used
  #     rspath_application_security_group = ""        # optional rspath to application security group
  #   }
  #   "example-allow-http-from-VirtualNetwork" = {
  #     priority                          = 100              # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
  #     direction                         = "Inbound"        # The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
  #     access                            = "Allow"          # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
  #     protocol                          = "*"              # (Required) Network protocol this rule applies to. Can be Tcp, Udp, Icmp, or * to match all.
  #     source_port_range                 = "*"              # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any
  #     destination_port_range            = "80"             # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any
  #     source_address_prefix             = "VirtualNetwork" # CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used
  #     destination_address_prefix        = "VirtualNetwork" # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used
  #     rspath_application_security_group = ""               # optional rspath to application security group

  # } }

}