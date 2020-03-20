output "id" {
  description = "Id of the dns zone created."
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  value = azurerm_private_dns_zone.this.name
}
