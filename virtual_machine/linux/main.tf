locals {

  priority        = var.spot_max_bid_price > 0 ? "Spot" : "Regular"
  eviction_policy = var.spot_max_bid_price > 0 ? "Deallocate" : null

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

  machine_extensions = [
    "#!/bin/bash\nset -eu",
    file("./machine_extensions/${var.linux_distribution}.sh"),
    length(var.rspath_managed_disks) > 0 ? file("./machine_extensions/data_disk.sh") : "",
    var.swap_size_mb > 0 ? "export SWAP_SIZE=${var.swap_size_mb}M" : "",
    "export SWAP_FILE=${var.swap_file}",
    "export SSH_USER=${var.ssh_user}",
    var.swap_size_mb > 0 ? file("./machine_extensions/swap.sh") : "",
    file("./machine_extensions/common.sh"),
    var.install_cifs ? file("./machine_extensions/cifs.sh") : "",
    var.install_python3 ? file("./machine_extensions/python3.sh") : "",
    var.install_docker ? file("./machine_extensions/docker.sh") : "",
    var.install_blobfuse ? file("./machine_extensions/blobfuse.sh") : "",
    var.install_azcli ? file("./machine_extensions/azcli.sh") : "",
    var.install_fail2ban ? file("./machine_extensions/fail2ban.sh") : ""
  ]

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

  location       = data.terraform_remote_state.resource_group.outputs.location
  size           = var.machine_size
  admin_username = var.ssh_user
  priority       = local.priority

  max_bid_price = var.spot_max_bid_price

  eviction_policy = local.eviction_policy

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

data "local_file" "custom_extensions" {
  count    = length(var.custom_machine_extensions)
  filename = var.custom_machine_extensions[count.index]
}

resource "azurerm_virtual_machine_extension" "init" {
  name                 = "${var.name}-init"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${base64gzip(join("\n", coalesce(local.machine_extensions), data.local_file.custom_extensions.*.content))}"
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