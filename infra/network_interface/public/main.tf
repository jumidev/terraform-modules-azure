
data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnet" {
  backend = "local"

  config = {
    path = "${var.rspath_subnet}/terraform.tfstate"
  }
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name}private"
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  dynamic "ip_configuration" {
    for_each = var.assign_public_ip ? [true] : []
    content {

      name                          = "public-plus-private"
      subnet_id                     = data.terraform_remote_state.subnet.outputs.id
      private_ip_address_allocation = var.private_ip_address_allocation
      public_ip_address_id          = azurerm_public_ip.this.0.id
    }
  }

  dynamic "ip_configuration" {
    for_each = var.assign_public_ip ? [] : [true]
    content {
      name                          = "private"
      subnet_id                     = data.terraform_remote_state.subnet.outputs.id
      private_ip_address_allocation = var.private_ip_address_allocation
    }

  }

  tags = var.tags



}

resource "azurerm_public_ip" "this" {
  count               = var.assign_public_ip ? 1 : 0
  name                = "${var.name}public"
  location            = var.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  allocation_method   = "Static"

  tags = var.tags

}