# Command to refresh outputs
# > terraform refresh

output "client_key" {
    value = "${azurerm_kubernetes_cluster.this.kube_config.0.client_key}"
}

output "client_certificate" {
    value = "${azurerm_kubernetes_cluster.this.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
    value = "${azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate}"
}

output "cluster_username" {
    value = "${azurerm_kubernetes_cluster.this.kube_config.0.username}"
}

output "cluster_password" {
    value = "${azurerm_kubernetes_cluster.this.kube_config.0.password}"
}

output "kube_config" {
    value = "${azurerm_kubernetes_cluster.this.kube_config_raw}"
}

output "host" {
    value = "${azurerm_kubernetes_cluster.this.kube_config.0.host}"
}

output "managed_disk_name" {
  value = azurerm_managed_disk.this.name
}

output "managed_disk_id" {
  value = azurerm_managed_disk.this.id
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "storage_account_key" {
  value = azurerm_storage_account.this.primary_access_key
}

output "share_file_name" {
  value = azurerm_storage_share.this.name
}

output "blob_storage_name" {
  value = azurerm_storage_container.this.name
}