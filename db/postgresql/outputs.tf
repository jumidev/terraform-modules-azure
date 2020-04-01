output "id" {
  description = "Id of postgresql server."
  value       = azurerm_postgresql_server.this.id
}

output "fqdn" {
  description = "FQDN of postgresql server."
  value       = azurerm_postgresql_server.this.fqdn
}


output "administrator_login" {
  value = var.administrator_login
}

output "administrator_password" {
  sensitive = true
  value     = local.administrator_password
}