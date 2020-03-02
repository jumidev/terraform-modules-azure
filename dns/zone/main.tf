locals {

}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "azurerm_dns_zone" "this" {
  name                = var.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
}
