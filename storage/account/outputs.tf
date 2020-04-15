output "id" {
  description = "Id of the storage account created."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Name of the storage account created."
  value       = azurerm_storage_account.this.name
}

output "primary_location" {
  description = "The primary location of the storage account.."
  value       = azurerm_storage_account.this.primary_location
}

output "secondary_location" {
  description = "The secondary location of the storage account."
  value       = azurerm_storage_account.this.secondary_location
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the primary location."
  value       = azurerm_storage_account.this.primary_blob_host
}

output "secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_blob_endpoint
}

output "secondary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_blob_host
}


output "primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location."
  value       = azurerm_storage_account.this.primary_queue_endpoint
}

output "primary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the primary location."
  value       = azurerm_storage_account.this.primary_queue_host
}

output "secondary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_queue_endpoint
}

output "secondary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_queue_host
}

output "primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location."
  value       = azurerm_storage_account.this.primary_table_endpoint
}

output "primary_table_host" {
  description = "The hostname with port if applicable for table storage in the primary location."
  value       = azurerm_storage_account.this.primary_table_host
}

output "secondary_table_endpoint" {
  description = "The endpoint URL for table storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_table_endpoint
}

output "secondary_table_host" {
  description = "The hostname with port if applicable for table storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_table_host
}

output "primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location."
  value       = azurerm_storage_account.this.primary_file_endpoint
}

output "primary_file_host" {
  description = "The hostname with port if applicable for file storage in the primary location."
  value       = azurerm_storage_account.this.primary_file_host
}

output "secondary_file_endpoint" {
  description = "The endpoint URL for file storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_file_endpoint
}

output "secondary_file_host" {
  description = "The hostname with port if applicable for file storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_file_host
}

output "primary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the primary location."
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}

output "primary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the primary location."
  value       = azurerm_storage_account.this.primary_dfs_host
}

output "secondary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_dfs_endpoint
}

output "secondary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_dfs_host
}

output "primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location."
  value       = azurerm_storage_account.this.primary_web_endpoint
}

output "primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = azurerm_storage_account.this.primary_web_host
}

output "secondary_web_endpoint" {
  description = "The endpoint URL for web storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_web_endpoint
}

output "secondary_web_host" {
  description = "The hostname with port if applicable for web storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_web_host
}

output "primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = azurerm_storage_account.this.secondary_connection_string
  sensitive   = true
}

output "primary_blob_connection_string" {
  description = "The connection string associated with the primary blob location."
  value       = azurerm_storage_account.this.primary_blob_connection_string
  sensitive   = true
}

output "secondary_blob_connection_string" {
  description = "The connection string associated with the secondary blob location."
  value       = azurerm_storage_account.this.secondary_blob_connection_string
  sensitive   = true
}

