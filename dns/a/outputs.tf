output "id" {
  description = "Id of the dns zone created."
  value       = azurerm_dns_a_record.this.id
}


output "fqdn" {
  description = "Id of the dns zone created."
  value       = azurerm_dns_a_record.this.fqdn
}
