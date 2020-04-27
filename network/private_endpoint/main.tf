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



# data "terraform_remote_state" "application_security_group" {
#   count   = var.rspath_application_security_group != "" ? 1 : 0
#   backend = "local"

#   config = {
#     path = "${var.rspath_application_security_group}/terraform.tfstate"
#   }
# }

# data "terraform_remote_state" "network_security_group" {
#   count   = var.rspath_network_security_group != "" ? 1 : 0
#   backend = "local"

#   config = {
#     path = "${var.rspath_network_security_group}/terraform.tfstate"
#   }
# }

# why not just have a single "this" resource with a conditional ip_configuration based on whether assign_public_ip is true ....?
# well the problem comes when you change the value from true to false,
# when tf attempts to delete the public ip resource it doesn't deallocate it first, resulting in a crash like this:

# Error: Error deleting Public IP "example" (Resource Group "example"): network.PublicIPAddressesClient#Delete: 
# Failure sending request: StatusCode=400 -- Original Error: Code="PublicIPAddressCannotBeDeleted" 
# Message="Public IP address /subscriptions/27aaasdfsdfsfec6f07/resourceGroups/example/providers/Microsoft.Network/publicIPAddresses/example 
# can not be deleted since it is still allocated to resource /subscriptions/27aaa3csdfsdf4991ec6f07/resourceGroups/example/providers/Microsoft.Network/networkInterfaces/example/ipConfigurations/this.
# In order to delete the public IP, disassociate/detach the Public IP address from the resource.  
# To learn how to do this, see aka.ms/deletepublicip." Details=[]

# this solution uses two separate resources, forcing a recreate

# resource "azurerm_network_interface" "private" {
#   count = var.assign_public_ip ? 0 : 1

#   name                          = "${var.name}-private"
#   location                      = data.terraform_remote_state.resource_group.outputs.location
#   resource_group_name           = data.terraform_remote_state.resource_group.outputs.name
#   enable_accelerated_networking = var.enable_accelerated_networking

#   ip_configuration {
#     name                          = "this"
#     subnet_id                     = data.terraform_remote_state.subnet.outputs.id
#     private_ip_address_allocation = var.private_ip_address_allocation
#   }
#   tags = var.tags

# }


# resource "azurerm_network_interface" "public" {
#   count = var.assign_public_ip ? 1 : 0

#   name                          = "${var.name}-public"
#   location                      = data.terraform_remote_state.resource_group.outputs.location
#   resource_group_name           = data.terraform_remote_state.resource_group.outputs.name
#   enable_accelerated_networking = var.enable_accelerated_networking


#   ip_configuration {
#     name                          = "this"
#     subnet_id                     = data.terraform_remote_state.subnet.outputs.id
#     private_ip_address_allocation = var.private_ip_address_allocation
#     public_ip_address_id          = azurerm_public_ip.this.0.id
#   }
#   tags = var.tags

# }

# resource "random_string" "unique" {
#   length  = 6
#   special = false
#   upper   = false
# }

# resource "azurerm_public_ip" "this" {
#   count               = var.assign_public_ip ? 1 : 0
#   name                = "${var.name}-public-${random_string.unique.result}"
#   location            = data.terraform_remote_state.resource_group.outputs.location
#   resource_group_name = data.terraform_remote_state.resource_group.outputs.name
#   allocation_method   = "Static"

#   tags = var.tags

# }

# # associate application security group to NIC
# resource "azurerm_network_interface_application_security_group_association" "this" {
#   count                         = var.rspath_application_security_group != "" ? 1 : 0
#   network_interface_id          = local.azurerm_network_interface.0.id
#   application_security_group_id = data.terraform_remote_state.application_security_group.0.outputs.id
# }

# # associate network security group to NIC
# resource "azurerm_network_interface_security_group_association" "this" {
#   count                     = var.rspath_network_security_group != "" ? 1 : 0
#   network_interface_id      = local.azurerm_network_interface.0.id
#   network_security_group_id = data.terraform_remote_state.network_security_group.0.outputs.id
# }