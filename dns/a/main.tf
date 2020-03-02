locals {
  
}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "dns_zone" {
  backend = "local"

  config = {
    path = "${var.rspath_dns_zone}/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_interface_private_ip" {
  count   = var.rspath_network_interface_private_ip != "" ? 1 : 0
  backend = "local"

  config = {
    path = "${var.rspath_network_interface_private_ip}/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_interface_public_ip" {
  count   = var.rspath_network_interface_public_ip != "" ? 1 : 0
  backend = "local"

  config = {
    path = "${var.rspath_network_interface_public_ip}/terraform.tfstate"
  }
}

resource "azurerm_dns_a_record" "this" {
  name                = var.name
  zone_name           = data.terraform_remote_state.dns_zone.outputs.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  ttl                 = var.ttl
  records             = compact(concat(
      data.terraform_remote_state.network_interface_private_ip.*.outputs.private_ip_address, 
      data.terraform_remote_state.network_interface_public_ip.*.outputs.public_ip_address,
      [var.ip]))
}
