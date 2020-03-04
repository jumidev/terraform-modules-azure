data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "application_security_groups" {
  count = length(var.rskey_application_security_groups)

  backend = "local"

  config = {
    path = "${var.rskey_application_security_groups[count.index]}/terraform.tfstate"
  }
}

resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority                   # 100
      direction                  = security_rule.value.direction                  # "Inbound"
      access                     = security_rule.value.access                     # "Allow"
      protocol                   = security_rule.value.protocol                   # "Tcp"
      source_port_range          = security_rule.value.source_port_range          # "*"
      destination_port_range     = security_rule.value.destination_port_range     # "*"
      source_address_prefix      = security_rule.value.source_address_prefix      # "*"
      destination_address_prefix = security_rule.value.destination_address_prefix # "*"

      source_application_security_group_ids = data.terraform_remote_state.application_security_groups.*.outputs.id

    }
  }

}