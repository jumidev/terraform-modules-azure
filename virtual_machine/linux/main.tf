locals {

  distributions = {
    # see `az vm image list`
    debian10 = {
      publisher = "Debian"
      offer     = "debian-10"
      sku       = "10"

    }
    ubuntu18lts = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
    }
    centos7 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.5"
    }

  }

  init_script = {
    k0_shebang   = "#!/bin/bash\nset -eu"
    k1_init      = file("./machine_extensions/${var.linux_distribution}.sh")
    k2_data_disk = length(var.rspath_managed_disks) > 0 ? file("./machine_extensions/data_disk.sh") : ""
    k3_docker    = var.install_docker ? file("./machine_extensions/docker.sh") : ""
    k4_blobfuse  = var.install_blobfuse ? file("./machine_extensions/blobfuse.sh") : ""
    k5_azcli     = var.install_azcli ? file("./machine_extensions/azcli.sh") : ""
    k6_fail2ban  = var.install_fail2ban ? file("./machine_extensions/fail2ban.sh") : ""
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

data "terraform_remote_state" "managed_disks" {
  count = length(var.rspath_managed_disks)

  backend = "local"

  config = {
    path = "${var.rspath_managed_disks[count.index]}/terraform.tfstate"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.name

  location       = var.location
  size           = var.machine_size
  admin_username = var.ssh_user

  network_interface_ids = data.terraform_remote_state.network_interfaces.*.outputs.id

  admin_ssh_key {
    username   = var.ssh_user
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

  additional_capabilities {
    ultra_ssd_enabled = var.ultra_ssd_enabled
  }


  dynamic "identity" {
    for_each = var.enable_system_assigned_managed_identity ? [true] : []
    content {
      type = "SystemAssigned"
    }
  }

  tags = var.tags
}


resource "azurerm_virtual_machine_extension" "init" {
  name                 = "${var.name}-init"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${base64gzip(join("\n", coalesce(values(local.init_script))))}"
    }
SETTINGS

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  count                     = length(var.rspath_managed_disks)
  managed_disk_id           = data.terraform_remote_state.managed_disks[count.index].outputs.id
  virtual_machine_id        = azurerm_linux_virtual_machine.this.id
  lun                       = count.index
  caching                   = "ReadWrite"
  write_accelerator_enabled = var.data_disk_write_accelerator
}