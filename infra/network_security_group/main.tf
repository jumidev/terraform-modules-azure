locals {
  # when priority not specified, auto assign them, starting at 200
  auto_priorities = {
    for i, k in keys(var.security_rules) :
    k => i + 200
  }

}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_application_security_group" "this" {

  for_each = {
    for k, i in var.security_rules :
    k => i.application_security_group
    if lookup(i, "application_security_group", "") != ""
  }

  resource_group_name = data.azurerm_resource_group.this.name
  name = each.value

}


resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  dynamic "security_rule" {
    # security rules with source address
    for_each = {
      for k, i in var.security_rules :
      k => i
      if lookup(i, "application_security_group", "") == ""
    }
    content {
      name                       = security_rule.key
      priority                   = lookup(security_rule.value, "priority", local.auto_priorities[security_rule.key])
      direction                  = lookup(security_rule.value, "direction", "Inbound")
      access                     = lookup(security_rule.value, "access", "Allow")
      protocol                   = lookup(security_rule.value, "protocol", "*")
      source_port_range          = lookup(security_rule.value, "source_port_range", "*")
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = lookup(security_rule.value, "source_address_prefix", "*")
      destination_address_prefix = security_rule.value.destination_address_prefix

    }
  }

  dynamic "security_rule" {
    # security rules with application_security_groups
    for_each = {
      for k, i in var.security_rules :
      k => i
      if lookup(i, "application_security_group", "") != ""
    }
    content {
      name                                  = security_rule.key
      priority                              = lookup(security_rule.value, "priority", local.auto_priorities[security_rule.key])
      direction                             = lookup(security_rule.value, "direction", "Inbound")
      access                                = lookup(security_rule.value, "access", "Allow")
      protocol                              = lookup(security_rule.value, "protocol", "*")
      source_port_range                     = lookup(security_rule.value, "source_port_range", "*")
      destination_port_range                = security_rule.value.destination_port_range
      destination_address_prefix            = lookup(security_rule.value, "destination_address_prefix", "*")
      source_application_security_group_ids = [lookup(data.azurerm_application_security_group.this, security_rule.key).id]
    }
  }

  dynamic "security_rule" {
    for_each = var.default_deny_inbound ? ["true"] : []
    content {
      name                       = "default-deny-inbound-${random_string.unique.result}"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  dynamic "security_rule" {
    for_each = var.default_allow_outbound ? ["true"] : []
    content {
      name                       = "default-allow-outbound-${random_string.unique.result}"
      priority                   = 4095
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }


}