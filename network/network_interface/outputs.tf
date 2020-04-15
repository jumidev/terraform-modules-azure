output "name" {
  description = "Name of the network interface"
  value       = local.azurerm_network_interface.0.name
}

output "id" {
  description = "ID of the network interface"
  value       = local.azurerm_network_interface.0.id
}

output "private_ip_address" {
  description = "First private ip of the network interface"
  value       = local.azurerm_network_interface.0.private_ip_address
}

output "private_ip_addresses" {
  description = "All private ips of the network interface"
  value       = local.azurerm_network_interface.0.private_ip_addresses
}

output "public_ip_address" {
  description = "Public ip of the network interface"
  value       = var.assign_public_ip ? azurerm_public_ip.this.0.ip_address : ""
}

output "mac_address" {
  value = local.azurerm_network_interface.0.mac_address
}

output "enable_accelerated_networking" {
  value = var.enable_accelerated_networking
}