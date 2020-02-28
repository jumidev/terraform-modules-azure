data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space       = var.address_spaces
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  tags = var.tags
}