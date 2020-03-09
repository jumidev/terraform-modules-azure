
locals {
  tcp = {
    for i in var.inmap :
    i.type => i.from_port...
    if i.protocol == "tcp"
  }

}





# resource "null_resource" "dynamic_self" {
#   for_each = var.inlist
#   provisioner "local-exec" {
#     command = "echo ${each.value.protocol}"
#   }
# }



