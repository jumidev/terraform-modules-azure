variable "service_principal_name" {
    default = "weathercluster-principal-dev"
}

variable rg_name {
    default = "k8s-dev"
}

variable vnet_name {
    default = "k8s-vnet"
}

variable vnet_address_space {
    default = "10.0.0.0/8"
}

variable subnet_name {
    default = "k8s-subnet"
}

variable subnet_address_prefix {
    default = "10.240.0.0/16"
}

variable "agent_count" {
    default = 1
}

variable "agent_min_count" {
    default = 1
}

variable "agent_max_count" {
    default = 20
}

variable "enable_auto_scaling" {
    default = true
}

variable "vm_default_size" {
    default = "Standard_B8ms"
}

variable "enable_dashboard" {
    default = true
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

variable kubernetes_version {
   default = "1.17.3"
}

# variable "ssh_public_key" {
#     default = "~/.ssh/id_rsa.pub"
# }
