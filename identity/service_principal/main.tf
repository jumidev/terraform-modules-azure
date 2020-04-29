# Create Azure AD App
resource "azuread_application" "this" {
  name                       = var.name
  available_to_other_tenants = var.available_to_other_tenants
  oauth2_allow_implicit_flow = var.oauth2_allow_implicit_flow
}

# Create Service Principal associated with the Azure AD App
resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
}

# Generate random string to be used as Service Principal password
resource "random_string" "password" {
  length  = var.password_lenght
  special = true
  # And keep it until a new service principal is generated
  keepers = {
    service_principal = azuread_service_principal.this.id
  }
}

# Create Service Principal password
resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
  value                = random_string.password.result
  end_date_relative    = var.end_date_relative
}

# Retrieves paths to resources ids for role assignment
data "terraform_remote_state" "role_assignment_ids" {
  for_each = var.role_assignments
  backend  = "local"

  config = {
    path = "${each.value.rspath_scope}/terraform.tfstate"
  }
}

# Multiple Azure Role Assignement
resource "azurerm_role_assignment" "this" {
  for_each             = var.role_assignments
  scope                = data.terraform_remote_state.role_assignment_ids[each.key].outputs.id
  role_definition_name = each.value.role_definition_name

  principal_id = azuread_service_principal.this.id
}
