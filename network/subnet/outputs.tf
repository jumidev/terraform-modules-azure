output "name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.this.name
}

output "id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.this.id
}

output "location" {
  description = "location of the resource."
  value       = azurerm_subnet.this.location
}

output "resource_group_name" {
  description = "resource_group_name of the resource."
  value       = azurerm_subnet.this.resource_group_name
}
