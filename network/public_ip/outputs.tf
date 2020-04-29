output "name" {
  description = "Name of the public IP"
  value       = azurerm_public_ip.this.name
}

output "id" {
  description = "ID of the public IP"
  value       = azurerm_public_ip.this.id
}

output "ip_address" {
  description = "IP address"
  value       = azurerm_public_ip.this.ip_address
}
