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

data "terraform_remote_state" "target_resource_id" {
  count = var.target_resource_id != "" ? 1 : 0

  backend = "local"

  config = {
    path = "${var.target_resource_id}/terraform.tfstate"
  }
}

resource "azurerm_dns_cname_record" "this_record" {
  count               = var.record != "" ? 1 : 0
  name                = var.name
  zone_name           = data.terraform_remote_state.dns_zone.outputs.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  ttl                 = var.ttl
  record              = var.record
}

resource "azurerm_dns_cname_record" "this_target_resource_id" {
  count               = var.target_resource_id != "" ? 1 : 0
  name                = var.name
  zone_name           = data.terraform_remote_state.dns_zone.outputs.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name
  ttl                 = var.ttl
  target_resource_id  = data.terraform_remote_state.target_resource_id.0.outputs.id
}