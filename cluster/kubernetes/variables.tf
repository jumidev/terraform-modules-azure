variable rg_name {
    default = "k8s-dev"
}

variable vnet_name {
    default = "k8s-vnet"
}

variable subnet_name {
    default = "k8s-subnet"
}

variable "agent_count" {
    default = 1
}

variable cluster_name {
    default = "weathercluster"
}

variable "dns_prefix" {
    default = "weathercluster"
}

variable location {
    default = "westeurope"
}

variable network_plugin {
    default = "azure" #"kubenet"
}

variable post_install_command {
    default = "bash ./post-install.sh"
}

#variable kubernetes_version {
#    default = "1.12.6"
#}

# variable "ssh_public_key" {
#     default = "~/.ssh/id_rsa.pub"
# }
