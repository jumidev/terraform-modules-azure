data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "azurerm_application_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  tags = var.tags

}