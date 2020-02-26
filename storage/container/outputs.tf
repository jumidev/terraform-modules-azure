output "container_id" {
  description = "Name of the storage container created."
  value       = azurerm_storage_container.storage.id
}

output "container_name" {
  description = "Name of the storage container created."
  value       = azurerm_storage_container.storage.name
}