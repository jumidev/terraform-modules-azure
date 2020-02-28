locals {
  soft_delete = var.is_hns_enabled ? 0 : var.soft_delete_retention != null ? 1 : 0
  name        = var.randomize_suffix ? format("%s%ssa", lower(replace(var.name, "/[[:^alnum:]]/", "")), random_string.unique.result) : var.name
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage" {
  name                      = local.name
  resource_group_name       = data.terraform_remote_state.resource_group.outputs.name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  is_hns_enabled            = var.is_hns_enabled
  enable_https_traffic_only = true

  dynamic "network_rules" {
    for_each = var.network_rules != null ? ["true"] : []
    content {
      default_action             = "Deny"
      ip_rules                   = var.network_rules.ip_rules
      virtual_network_subnet_ids = var.network_rules.subnet_ids
      bypass                     = var.network_rules.bypass
    }
  }

  tags = var.tags
}

resource "null_resource" "soft_delete" {
  count = local.soft_delete

  # TODO Not possible to do with azuread resources
  provisioner "local-exec" {
    command = "az storage blob service-properties delete-policy update --days-retained ${var.soft_delete_retention} --account-name ${azurerm_storage_account.storage.name} --enable true --subscription ${data.azurerm_client_config.current.subscription_id}"
  }

  depends_on = [azurerm_storage_account.storage]
}



