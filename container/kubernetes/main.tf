# Local variables
locals {
  client_id     = chomp(file("/keybase/team/weatherforce.infra/service-principal/dev/client-id"))
  client_secret = chomp(file("/keybase/team/weatherforce.infra/service-principal/dev/client-secret"))
}

# Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "this" {
    name                = var.cluster_name
    location            = var.location
    resource_group_name = var.rg_name
    dns_prefix          = var.dns_prefix
    node_resource_group = format("%s-%s-%s", var.cluster_name, var.rg_name, "rg") # "weathercluste-rg"
    # kubernetes_version  = var.kubernetes_version

    service_principal {
        client_id     = local.client_id
        client_secret = local.client_secret
    }

    # linux_profile {
    #     admin_username = "azureuser"

    #     ssh_key {
    #         key_data = file(var.ssh_public_key)
    #     }
    # }

    network_profile {
        network_plugin = var.network_plugin
        network_policy = var.network_plugin
        load_balancer_sku  = "Standard"
        load_balancer_profile {
            outbound_ip_address_ids = [ azurerm_public_ip.this.id ]
        }
    }

    role_based_access_control {
        enabled = true
    }

    default_node_pool {
        name                = "default"
        vm_size             = "Standard_B2s"
        enable_auto_scaling = true
        node_count          = var.agent_count
        min_count           = 1
        max_count           = 20
        type                = "VirtualMachineScaleSets"
        vnet_subnet_id      = azurerm_subnet.this.id
    }

    addon_profile {
        kube_dashboard {
        enabled = true
        }
    }

    depends_on = [
        azurerm_public_ip.this,
        azurerm_subnet.this,
        azurerm_subnet_route_table_association.this,
        # azurerm_network_interface_security_group_association.this,
        azurerm_subnet_network_security_group_association.this        
    ]

    tags = {
        Environment = "dev"
    }

    provisioner "local-exec" {
        command = var.post_install_command

        environment = {
            AKS_NAME = var.cluster_name
            AKS_RG   = var.rg_name
        }
    }
}

#  Additional Node Pool
# resource "azurerm_kubernetes_cluster_node_pool" "aks-np" {
#     name                  = "gpu"
#     kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

#     vm_size               = "Standard_B2s"
#     enable_auto_scaling   = true
#     node_count            = var.agent_count
#     min_count             = 1
#     max_count             = 20
#     vnet_subnet_id        = azurerm_subnet.subnet.id
# }

# Public IP
resource "azurerm_public_ip" "this" {
    name                = format("%s-%s", var.cluster_name, "ip")
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    allocation_method   = "Static"
    sku = "Standard"
}

# Azure principal service
data "azuread_service_principal" "this" {
  application_id = local.client_id
}

# Azure Role Assignement
resource "azurerm_role_assignment" "netcontribrole" {
  scope                = azurerm_subnet.this.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.this.object_id
}

# resource "azurerm_network_interface" "this" {
#   #count               = "${var.node_count}"
#   name                = format("%s-%s", var.cluster_name, "interface")
#   resource_group_name = var.rg_name
#   location            = var.location

#   enable_ip_forwarding      = true

#   ip_configuration {
#     name                          = format("%s-%s", var.cluster_name, "ipconfig")
#     private_ip_address_allocation = "dynamic"
#     public_ip_address_id          = azurerm_public_ip.this.id #"${element(azurerm_public_ip.k8s-service-minion-publicip.*.id, count.index)}"
#     subnet_id                     = azurerm_subnet.this.id
#   }
# }

# resource "azurerm_network_interface_security_group_association" "this" {
#   network_interface_id      = azurerm_network_interface.this.id
#   network_security_group_id = azurerm_network_security_group.this.id
# }