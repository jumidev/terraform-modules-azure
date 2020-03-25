# # Public IP
# resource "azurerm_public_ip" "this" {
#     name                = format("%s-%s", var.cluster_name, "ip")
#     location            = azurerm_resource_group.this.location
#     resource_group_name = azurerm_resource_group.this.name
#     allocation_method   = "Static"
#     sku = "Standard"
# }

# resource "azurerm_managed_disk" "this" {
#   name                 = "weathercluster-ssd"
#   location             = azurerm_resource_group.this.location
#   resource_group_name  = azurerm_resource_group.this.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = "512"

# }

# resource "azurerm_role_assignment" "netcontribroleX" {
#   scope                = azurerm_managed_disk.this.id
#   role_definition_name = "Network Contributor"
#   principal_id         = data.azuread_service_principal.this.object_id
# }

# ------------------------------------------------------------------------ #

# # Network Security Group
# resource "azurerm_network_security_group" "this" {
#     name                = format("%s-%s", var.cluster_name, "nsg")
#     location            = azurerm_resource_group.this.location
#     resource_group_name = azurerm_resource_group.this.name

#     security_rule {
#         name                       = "port_80"
#         priority                   = 100
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "*"
#         source_address_prefix    = "*"
#         destination_address_prefix = "*"
#     }

# }


# # Association of the NSG with the subnet
# resource "azurerm_subnet_network_security_group_association" "this" {
#     subnet_id                 = azurerm_subnet.this.id
#     network_security_group_id = azurerm_network_security_group.this.id
# }

# ------------------------------------------------------------------------ #

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

# ------------------------------------------------------------------------ #

# Azure Role Assignement
# resource "azurerm_role_assignment" "netcontribrole" {
#   scope                = azurerm_subnet.this.id
#   role_definition_name = "Network Contributor"
#   principal_id         = data.azuread_service_principal.this.object_id
# }


# resource "azurerm_role_assignment" "netcontribrole1" {
#   scope                = azurerm_virtual_network.this.id
#   role_definition_name = "Network Contributor"
#   principal_id         = data.azuread_service_principal.this.object_id
# }

# resource "azurerm_role_assignment" "netcontribrole2" {
#   scope                = azurerm_public_ip.this.id
#   role_definition_name = "Network Contributor"
#   principal_id         = data.azuread_service_principal.this.object_id
# }

# resource "azurerm_role_assignment" "netcontribrole3" {
#   scope                = azurerm_public_ip.this2.id
#   role_definition_name = "Network Contributor"
#   principal_id         = data.azuread_service_principal.this.object_id
# }

# resource "azurerm_network_interface" "this" {
#   #count               = "${var.node_count}"
#   name                = format("%s-%s", var.cluster_name, "interface")
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location

#   enable_ip_forwarding      = true

#   ip_configuration {
#     name                          = format("%s-%s", var.cluster_name, "ipconfig")
#     private_ip_address_allocation = "dynamic"
#     public_ip_address_id          = azurerm_public_ip.this.id #"${element(azurerm_public_ip.k8s-service-minion-publicip.*.id, count.index)}"
#     subnet_id                     = azurerm_subnet.this.id
#   }
# }

# resource "azurerm_network_interface_security_group_association" "this" {
#   network_interface_id      = azurerm_network_interface.this.id
#   network_security_group_id = azurerm_network_security_group.this.id
# }


# resource "azurerm_lb" "this" {
#   name                = "example-lb"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name
#   sku                 = "Standard"

#   frontend_ip_configuration {
#     name                 = "primary"
#     public_ip_address_id = azurerm_public_ip.this.id
#   }
# }

# resource "azurerm_lb_backend_address_pool" "this" {
#   resource_group_name = azurerm_resource_group.this.name
#   loadbalancer_id     = azurerm_lb.this.id
#   name                = "acctestpool"
# }

# resource "azurerm_network_interface" "this" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name

#     # enable_ip_forwarding      = true
#   ip_configuration {
#     name                          = "testconfiguration1"
#     subnet_id                     = azurerm_subnet.this.id
#     private_ip_address_allocation = "Dynamic"
#     # public_ip_address_id          = azurerm_public_ip.this.id
#   }
# }

# resource "azurerm_network_interface_backend_address_pool_association" "this" {
#   network_interface_id    = azurerm_network_interface.this.id
#   ip_configuration_name   = "testconfiguration1"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
# }

# resource "azurerm_lb_outbound_rule" "this" {
#   resource_group_name     = azurerm_resource_group.this.name
#   loadbalancer_id         = azurerm_lb.this.id
#   name                    = "OutboundRule"
#   protocol                = "All"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.this.id

#   frontend_ip_configuration {
#     name = "primary"
#   }
# }


