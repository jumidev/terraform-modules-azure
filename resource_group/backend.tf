provider "azurerm" {
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  tenant_id       = var.arm_tenant_id
  subscription_id = var.arm_subscription_id
  features {}
}


terraform {
  required_version = ">= 0.12.0"
  backend "local" {}
}

variable arm_client_id {
  type = string
}

variable arm_client_secret {
  type = string
}

variable arm_tenant_id {
  type = string
}

variable arm_subscription_id {
  type = string
}
