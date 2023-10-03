output "name" {
  description = "Name of the resource."
  value       = var.name
}

output "id" {
  description = "Id of the resource."
  value       = azurerm_application_security_group.this.id
}

output "resource_group_name" {
  description = "resource_group_name of the resource."
  value       = data.azurerm_resource_group.this.name
}

output "location" {
  description = "location of the resource."
  value       = data.azurerm_resource_group.this.location
}