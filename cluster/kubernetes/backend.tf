terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = "= 2.1.0"
  }
  backend "local" {}
}

# Azure Ressource Manager
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "= 2.1.0"
  features {}
}

# Azure Active Directory
provider "azuread" {
  version = ">= 0.7"
}

provider "random" {
  version = "= 2.1.0"
}