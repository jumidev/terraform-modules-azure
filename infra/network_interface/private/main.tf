
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


  ip_configuration {
    name                          = "private"
    subnet_id                     = data.terraform_remote_state.subnet.outputs.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
  tags = var.tags

}
