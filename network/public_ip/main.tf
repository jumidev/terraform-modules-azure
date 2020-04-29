
data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "azurerm_public_ip" "this" {
  name                = var.name
  location            = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  sku                 = var.sku
  allocation_method   = var.allocation_method
  domain_name_label   = var.domain_name_label
  reverse_fqdn        = var.reverse_fqdn

  tags = var.tags
}
