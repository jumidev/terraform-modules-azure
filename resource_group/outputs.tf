output "name" {
  description = "Name of the resource group."
  value       = var.name
}

output "id" {
  description = "Id of the resource group."
  value       = azurerm_resource_group.this.id
}
