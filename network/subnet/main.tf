locals {
  enforce_private_link_endpoint_network_policies = length(var.service_endpoints) > 0 ? true : var.enforce_private_link_endpoint_network_policies
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
}


resource "azurerm_subnet" "this" {
  name                 = var.name
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
  # naming this "address_prefix" is inconsistent, since the virtual_network
  # component calls it "address_space", so using var.address_space
  address_prefix                                 = var.address_space
  enforce_private_link_endpoint_network_policies = local.enforce_private_link_endpoint_network_policies
  enforce_private_link_service_network_policies  = var.enforce_private_link_service_network_policies
  service_endpoints                              = var.service_endpoints

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.name
        actions = compact(split(" ", delegation.value.actions))
      }
    }
  }

}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = var.network_security_group_id != "" ? 1 : 0
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = var.network_security_group_id
}
