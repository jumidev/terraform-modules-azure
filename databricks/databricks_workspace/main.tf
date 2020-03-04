locals {

}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}


data "terraform_remote_state" "virtual_network" {
  backend = "local"

  config = {
    path = "${var.rspath_virtual_network}/terraform.tfstate"
  }
}

data "terraform_remote_state" "public_subnet" {
  backend = "local"

  config = {
    path = "${var.rspath_public_subnet}/terraform.tfstate"
  }
}

data "terraform_remote_state" "private_subnet" {
  backend = "local"

  config = {
    path = "${var.rspath_private_subnet}/terraform.tfstate"
  }
}


resource "azurerm_databricks_workspace" "this" {
  name                = var.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  location            = var.location
  sku                 = var.sku

  custom_parameters {
    no_public_ip        = var.no_public_ip
    private_subnet_name = data.terraform_remote_state.private_subnet.outputs.name
    public_subnet_name  = data.terraform_remote_state.public_subnet.outputs.name
    virtual_network_id  = data.terraform_remote_state.virtual_network.outputs.id
  }

  tags = var.tags
}


