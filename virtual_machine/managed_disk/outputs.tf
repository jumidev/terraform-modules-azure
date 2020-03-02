output "id" {
  description = "Id of the disk created."
  value       = azurerm_managed_disk.this.id
}

output "size" {
  description = "size of the disk in GB."
  value       = var.size
}