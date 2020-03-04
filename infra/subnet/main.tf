
data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "virtual_network" {
  backend = "local"

  config = {
    path = "${var.rspath_virtual_network}/terraform.tfstate"
  }
}


data "terraform_remote_state" "network_security_groups" {
  count   = length(var.rspath_network_security_groups)
  backend = "local"

  config = {
    path = "${var.rspath_network_security_groups[count.index]}/terraform.tfstate"
  }
}

resource "azurerm_subnet" "this" {
  name                 = var.name
  resource_group_name  = data.terraform_remote_state.resource_group.outputs.name
  virtual_network_name = data.terraform_remote_state.virtual_network.outputs.name
  # naming this "address_prefix" is inconsistent, since the virtual_network
  # component calls it "address_space", so using var.address_space
  address_prefix                                 = var.address_space
  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies
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
  count                     = length(var.rspath_network_security_groups)
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = data.terraform_remote_state.network_security_groups[count.index].outputs.id
}

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_network_security_group" "deny" {
  count               = var.default_deny_incoming ? 1 : 0
  name                = "${data.terraform_remote_state.virtual_network.outputs.name}-${var.name}-${random_string.unique.result}-deny-incoming"
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  security_rule {
    name                       = "DefaultDenyAll"
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

resource "azurerm_subnet_network_security_group_association" "this_deny" {
  count = var.default_deny_incoming ? 1 : 0

  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.deny.0.id
}