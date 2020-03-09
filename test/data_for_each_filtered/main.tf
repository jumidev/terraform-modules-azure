
locals {
  wasg = {
    for k, i in var.security_rules :
    k => i.rskey_application_security_group
    if lookup(i, "rskey_application_security_group", "") != ""
  }

  woasg = {
    for k, i in var.security_rules :
    k => i.source_address_prefix...
    if lookup(i, "rskey_application_security_group", "") == ""
  }

}

data "terraform_remote_state" "application_security_groups" {
  for_each = {
    for k, i in var.security_rules :
    k => i
    if lookup(i, "rskey_application_security_group", "") != ""
  }

  backend = "local"

  config = {
    path = "${each.value.rskey_application_security_group}/terraform.tfstate"
  }


}

# data "terraform_remote_state" "application_security_groups" {
#   count = length(var.rskey_application_security_groups)

#   backend = "local"

#   config = {
#     path = "${var.rskey_application_security_groups[count.index]}/terraform.tfstate"
#   }
# }


# resource "null_resource" "dynamic_self" {
#   for_each = var.inlist
#   provisioner "local-exec" {
#     command = "echo ${each.value.protocol}"
#   }
# }



