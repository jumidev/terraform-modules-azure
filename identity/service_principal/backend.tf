terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = "~> 2.4.0"
  }

  backend "local" {}
}

provider "azurerm" {
  version = "~> 2.4.0"
  features {}
}

# Azure Active Directory
provider "azuread" {
  version = ">= 0.7"
}

provider "random" {
  version = "= 2.1.0"
}
