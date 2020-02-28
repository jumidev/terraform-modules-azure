locals {

  distributions = {
    # see `az vm image list`
    debian = {
      publisher = "Debian"
      offer     = "debian-10"
      sku       = "10"

    }
    ubuntu = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04-LTS"
    }
    centos = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.5"
    }

  }
}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "${var.rspath_resource_group}/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_interfaces" {
  count = length(var.rspath_network_interfaces)

  backend = "local"

  config = {
    path = "${var.rspath_network_interfaces[count.index]}/terraform.tfstate"
  }
}


resource "azurerm_linux_virtual_machine" "this" {
  name                = var.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  location       = var.location
  size           = var.size
  admin_username = "automation"

  network_interface_ids = data.terraform_remote_state.network_interfaces.*.outputs.id

  admin_ssh_key {
    username   = "automation"
    public_key = file(var.public_key_file)
  }

  os_disk {
    caching                   = var.os_disk_caching              #"ReadWrite"
    storage_account_type      = var.os_disk_storage_account_type #"Standard_LRS"
    write_accelerator_enabled = var.os_disk_write_accelerator_enabled
  }

  source_image_reference {
    publisher = lookup(local.distributions, var.linux_distribution).publisher
    offer     = lookup(local.distributions, var.linux_distribution).offer
    sku       = lookup(local.distributions, var.linux_distribution).sku
    version   = "latest"
  }
}


