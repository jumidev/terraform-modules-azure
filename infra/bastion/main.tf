
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

resource "azurerm_public_ip" "this" {
  name                = "bastionip"
  location            = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "this" {
  name                = var.name
  location            = data.terraform_remote_state.resource_group.outputs.location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.terraform_remote_state.subnet.outputs.id
    public_ip_address_id = azurerm_public_ip.this.id
  }
}