output "id" {
  description = "Id of the VM created."
  value       = azurerm_linux_virtual_machine.this.id
}

output "name" {
  description = "Name VM created."
  value       = azurerm_linux_virtual_machine.this.name
}