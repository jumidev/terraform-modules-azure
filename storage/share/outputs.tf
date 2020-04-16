output "name" {
  description = "Name of the storage share created."
  value       = var.name
}

output "id" {
  description = "id of the storage share created."
  value       = azurerm_storage_share.this.id
}

output "resource_manager_id" {
  description = "resource_manager_id of the storage share created."
  value       = azurerm_storage_share.this.resource_manager_id
}

output "url" {
  description = "URL of the storage share created."
  value       = azurerm_storage_share.this.url
}