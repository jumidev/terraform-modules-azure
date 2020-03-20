# Azure vnet
resource "azurerm_virtual_network" "this" {
    name                = var.vnet_name
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    address_space       = ["10.0.0.0/8"]
}

# Azure subnet
resource "azurerm_subnet" "this" {
    name                 = var.subnet_name
    resource_group_name  = azurerm_resource_group.this.name
    address_prefix       = "10.240.0.0/16"
    virtual_network_name = azurerm_virtual_network.this.name
}
