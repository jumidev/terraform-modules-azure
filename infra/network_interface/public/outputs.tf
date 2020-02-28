output "name" {
  description = "Name of the network interface"
  value       = azurerm_network_interface.this.name
}

output "id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "First private ip of the network interface"
  value       = azurerm_network_interface.this.private_ip_address
}

output "private_ip_addresses" {
  description = "All private ips of the network interface"
  value       = azurerm_network_interface.this.private_ip_addresses
}

output "public_ip_address" {
  description = "Public ip of the network interface"
  value       = var.assign_public_ip ? azurerm_public_ip.this.0.ip_address : ""
}
