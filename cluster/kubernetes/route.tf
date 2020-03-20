# # Route Table
# resource "azurerm_route_table" "this" {
#   resource_group_name   = azurerm_resource_group.this.name
#   location              = azurerm_resource_group.this.location
#   name                  = format("%s-%s", var.cluster_name, "rt")

#   route {
#     name                   = "default"
#     address_prefix         = "10.100.0.0/14"
#     next_hop_type          = "VirtualAppliance"
#     next_hop_in_ip_address = "10.10.1.1"
#   }

# }

# # Association of the Route Table with the subnet
# resource "azurerm_subnet_route_table_association" "this" {
#     subnet_id      = azurerm_subnet.this.id
#     route_table_id = azurerm_route_table.this.id

#     depends_on = [
#         azurerm_route_table.this
#     ]
# }
