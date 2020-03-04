output "id" {
  description = "Id of the dns record created."
  value       = var.record != "" ? azurerm_dns_cname_record.this_record.0.id : azurerm_dns_cname_record.this_target_resource_id.0.id
}

