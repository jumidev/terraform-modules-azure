output "id" {
  description = "Id of the dns record."
  value       = azurerm_private_dns_a_record.this.id
}

output "fqdn" {
  description = "FQDN of the dns a record."
  value       = azurerm_private_dns_a_record.this.fqdn
}
