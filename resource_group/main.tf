terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = ">= 1.33.0"
  }
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location

  tags = var.tags
}



