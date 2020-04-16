output "name" {
  description = "Name of the resource."
  value       = var.name
}

output "id" {
  description = "Id of the resource."
  value       = azurerm_virtual_network.this.id
}
