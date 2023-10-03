output "name" {
  description = "Name of the resource."
  value       = var.name
}

output "id" {
  description = "Id of the resource."
  value       = azurerm_virtual_network.this.id
}


output "location" {
  description = "location of the resource."
  value       = azurerm_virtual_network.this.location
}

output "resource_group_name" {
  description = "resource_group_name of the resource."
  value       = azurerm_virtual_network.this.resource_group_name
}

output "guid" {
  description = "guid of the resource."
  value       = azurerm_virtual_network.this.guid
}

output "subnet" {
  description = "subnet of the resource."
  value       = azurerm_virtual_network.this.subnet
}