output "service_principal_id" {
  description = "Service principal ID."
  value       = azuread_service_principal.this.application_id
}

output "service_principal_name" {
  description = "Service principal name."
  value       = var.name
}

output "service_principal_key" {
  description = "Service principal password."
  value       = azuread_service_principal_password.this.value
  sensitive   = true
}

output "role_assignments" {
  description = "Role assignments dictionnary."
  value       = var.role_assignments
}
