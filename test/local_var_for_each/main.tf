
locals {
  outstring = join("\n", ["lol"], data.local_file.this.*.content)
}

data "local_file" "this" {
  count    = length(var.inlist)
  filename = var.inlist[count.index]
}