# data "terraform_remote_state" "resource_group" {
#   backend = "local"

#   config = {
#     path = "${var.rspath_resource_group}/terraform.tfstate"
#   }
# }

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}


# data "terraform_remote_state" "private_dns" {
#   count   = length(var.rspath_private_dns_zones)
#   backend = "local"

#   config = {
#     path = "${var.rspath_private_dns_zones[count.index]}/terraform.tfstate"
#   }
# }

resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space       = var.address_spaces
  location            = data.azurerm_resource_group.location
  resource_group_name = data.azurerm_resource_group..name

  tags = var.tags
}

# resource "azurerm_private_dns_zone_virtual_network_link" "this" {
#   count = length(var.rspath_private_dns_zones)

#   name                  = "link-${var.name}-to-${data.terraform_remote_state.private_dns[count.index].outputs.name}"
#   resource_group_name   = data.terraform_remote_state.resource_group.outputs.name
#   private_dns_zone_name = data.terraform_remote_state.private_dns[count.index].outputs.name
#   virtual_network_id    = azurerm_virtual_network.this.id
# }
