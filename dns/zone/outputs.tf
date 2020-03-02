output "id" {
  description = "Id of the dns zone created."
  value       = azurerm_dns_zone.this.id
}

output "name" {
  value = azurerm_dns_zone.this.name
}

output "name_servers" {
  description = "name_servers for this dns zone."
  value       = azurerm_dns_zone.this.name_servers
}