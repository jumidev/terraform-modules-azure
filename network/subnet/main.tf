locals {
  enforce_private_link_endpoint_network_policies = length(var.service_endpoints) > 0 ? true : var.enforce_private_link_endpoint_network_policies

}
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

data "terraform_remote_state" "network_security_group" {
  count   = var.rspath_network_security_group != "" ? 1 : 0
  backend = "local"

  config = {
    path = "${var.rspath_network_security_group}/terraform.tfstate"
  }
}

resource "azurerm_subnet" "this" {
  name                 = var.name
  resource_group_name  = data.terraform_remote_state.resource_group.outputs.name
  virtual_network_name = data.terraform_remote_state.virtual_network.outputs.name
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
  count                     = var.rspath_network_security_group != "" ? 1 : 0
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = data.terraform_remote_state.network_security_group.0.outputs.id
}
