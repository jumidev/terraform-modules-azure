# locals {
#   azurerm_network_interface = concat(azurerm_network_interface.private, azurerm_network_interface.public)
# }


data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnet" {
  backend = "local"

  config = {
    path = "${var.rspath_subnet}/terraform.tfstate"
  }
}

data "terraform_remote_state" "private_connection_resource" {
  backend = "local"

  config = {
    path = "${var.rspath_private_connection_resource}/terraform.tfstate"
  }
}


resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  subnet_id           = data.terraform_remote_state.subnet.outputs.id


  private_service_connection {

    name                           = var.name
    is_manual_connection           = false
    private_connection_resource_id = data.terraform_remote_state.private_connection_resource.outputs.id
    subresource_names              = var.subresource_names #["blob", "file", "queues"]
  }


  # private_service_connection {
  #   name                           = var.name
  #   private_connection_resource_id = azurerm_private_link_service.example.id
  #   is_manual_connection           = false
  # }
}


