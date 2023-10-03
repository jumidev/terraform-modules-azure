provider "azurerm" {
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
  features {}
}

terraform {
  required_version = ">= 0.12.0"
  backend "local" {}
}

variable azure_client_id {
  type = string
}

variable azure_client_secret {
  type = string
}

variable azure_tenant_id {
  type = string
}

variable azure_subscription_id {
  type = string
}
