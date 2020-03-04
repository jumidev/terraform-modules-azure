output "id" {
  description = "Id of the resource."
  value       = azurerm_network_security_group.this.id
}


output "name" {
  description = "Name of the resource."
  value       = var.name
}

