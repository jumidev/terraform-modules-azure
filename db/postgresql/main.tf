locals {
  administrator_password = length(var.administrator_password) > 5 ? var.administrator_password : random_password.this.result
}

resource "random_password" "this" {
  length           = 32
  special          = true
  override_special = "_%@"
}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "azurerm_postgresql_server" "this" {
  name                = var.name
  location            = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  sku_name = var.sku_name

  storage_profile {
    storage_mb            = var.storage_mb
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup  = var.geo_redundant_backup
    auto_grow             = var.auto_grow
  }

  administrator_login          = var.administrator_login
  administrator_login_password = local.administrator_password
  version                      = var.postgresql_version
  ssl_enforcement              = var.ssl_enforcement
}