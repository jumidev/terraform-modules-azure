data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "source_application_security_groups" {
  count = length(var.inbound_security_rules)

  backend = "local"

  config = {
    path = "${var.inbound_security_rules[count.index].name}/terraform.tfstate"
  }
}

resource "azurerm_application_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  dynamic "security_rule" {
    for_each = var.inbound_security_rules
    content {

      name                       = var.inbound_security_rules[count.index].name
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"

      source_application_security_group_ids = []

    }
  }
  tags = var.tags

}