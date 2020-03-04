resource "null_resource" "dynamic_self" {
  for_each = var.inlist


  provisioner "local-exec" {
    command = "echo ${each.value.protocol}"
  }
}



