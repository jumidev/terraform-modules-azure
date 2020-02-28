output "name" {
  description = "Name of the bastion"
  value       = var.name
}

output "id" {
  description = "ID of the bastion"
  value       = azurerm_bastion_host.this.id
}

output "public_ip" {
  description = "Public ip of the bastion"
  value       = azurerm_public_ip.this.ip_address
}

output "public_fqdn" {
  description = "DNS of the bastion"
  value       = azurerm_bastion_host.this.dns_name
} 