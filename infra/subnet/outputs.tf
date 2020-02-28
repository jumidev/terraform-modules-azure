output "name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.this.name
}

output "id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.this.id
} 