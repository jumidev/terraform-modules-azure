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


data "terraform_remote_state" "subnets" {
  count   = length(var.rspath_subnets)
  backend = "local"

  config = {
    path = "${var.rspath_subnets[count.index]}/terraform.tfstate"
  }
}


resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "this" {
  name                      = local.name
  resource_group_name       = data.terraform_remote_state.resource_group.outputs.name
  location                  = data.terraform_remote_state.resource_group.outputs.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  is_hns_enabled            = var.is_hns_enabled
  enable_https_traffic_only = true

  # dynamic "network_rules" {
  #   for_each = var.network_rules != null ? ["true"] : []
  #   content {
  #     default_action             = "Deny"
  #     ip_rules                   = var.network_rules.ip_rules
  #     virtual_network_subnet_ids = var.network_rules.subnet_ids
  #     bypass                     = var.network_rules.bypass
  #   }
  # }

  dynamic "network_rules" {
    for_each = data.terraform_remote_state.subnets
    content {
      default_action = "Deny"
      # subnet will need to have Microsoft.Storage in its service_endpoint input variable
      virtual_network_subnet_ids = [network_rules.value.outputs.id]
      # without this bypass, using the console to manage objects unde the share become broken
      bypass = ["AzureServices"]
    }
  }

  tags = var.tags
}


