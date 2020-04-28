# Create Azure AD App
resource "azuread_application" "this" {
  name                       = var.name
  available_to_other_tenants = false #var.available_to_other_tenants
  oauth2_allow_implicit_flow = false #var.oauth2_allow_implicit_flow
}

# Create Service Principal associated with the Azure AD App
resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
}

data "terraform_remote_state" "role_assignment_ids" {
  for_each = var.role_assignments

  backend = "local"

  config = {
    path = "${each.value.rspath_scope}/terraform.tfstate"
  }
}


# Azure Role Assignement
resource "azurerm_role_assignment" "this" {
  for_each             = var.role_assignment
  scope                = data.terraform_remote_state.role_assignment_ids[each.key].outputs.id
  role_definition_name = each.value.role_definition_name # "Network Contributor"

  principal_id = azuread_service_principal.this.id
}
