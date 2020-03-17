# Network Security Group
resource "azurerm_network_security_group" "this" {
    name                = format("%s-%s", var.cluster_name, "nsg")
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name

    security_rule {
        name                       = "port_80"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix    = "*"
        destination_address_prefix = "*"
    }

}

# Association of the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "this" {
    subnet_id                 = azurerm_subnet.this.id
    network_security_group_id = azurerm_network_security_group.this.id
}
