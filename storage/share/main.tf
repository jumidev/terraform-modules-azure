locals {
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "storage_account" {
  backend = "local"

  config = {
    path = "${var.rspath_storage_account}/terraform.tfstate"
  }
}

resource "azurerm_storage_share" "this" {
  name                 = var.name
  storage_account_name = data.terraform_remote_state.storage_account.outputs.name
  quota                = var.quota
}

