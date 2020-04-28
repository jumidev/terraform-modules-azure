# output "name" {
#   description = "Name of the resource."
#   value       = var.name
# }

# output "id" {
#   description = "Id of the resource."
#   value       = azurerm_application_security_group.this.id
# }


output "role_assignments" {
  description = "role assignments."
  value       = var.role_assignments
}

# output "rs_states_role_assignments" {
#   description = "role assignments."
#   value       = data.terraform_remote_state.role_assignment_ids
# }