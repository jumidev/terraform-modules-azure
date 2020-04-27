output "name" {
  description = "Name of the network interface"
  value       = var.name
}

output "id" {
  description = "ID of the azurerm_private_endpoint"
  value       = azurerm_private_endpoint.this.id
}

output "private_ip_address" {
  description = "ID of the azurerm_private_endpoint"
  value       = azurerm_private_endpoint.this.private_service_connection.0.private_ip_address
}

output "request_message" {
  description = "First private ip of the network interface"
  value       = azurerm_private_endpoint.this.private_service_connection.0.request_message
}
