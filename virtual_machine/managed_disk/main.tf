locals {

}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "azurerm_managed_disk" "this" {
  name                 = var.name
  location             = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name  = data.terraform_remote_state.resource_group.outputs.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.size

  tags = var.tags
}
