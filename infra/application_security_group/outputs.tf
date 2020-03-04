output "name" {
  description = "Name of the resource."
  value       = var.name
}

output "id" {
  description = "Id of the resource."
  value       = azurerm_application_security_group.this.id
}
