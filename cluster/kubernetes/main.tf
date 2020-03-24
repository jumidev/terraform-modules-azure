# Local variables
locals {
  client_id     = chomp(file("/keybase/team/weatherforce.infra/service-principal/dev/client-id"))
  client_secret = chomp(file("/keybase/team/weatherforce.infra/service-principal/dev/client-secret"))
}

# Resource Group
resource "azurerm_resource_group" "this" {
    name     = var.rg_name
    location = var.location
}

# Azure vnet
resource "azurerm_virtual_network" "this" {
    name                = var.vnet_name
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    address_space       = ["10.0.0.0/8"]
}

# Azure subnet
resource "azurerm_subnet" "this" {
    name                 = var.subnet_name
    resource_group_name  = azurerm_resource_group.this.name
    address_prefix       = "10.240.0.0/16"
    virtual_network_name = azurerm_virtual_network.this.name
}

# Azure principal service
data "azuread_service_principal" "this" {
  application_id = local.client_id
}

# Azure Role Assignement
resource "azurerm_role_assignment" "netcontribrole" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.this.object_id
}

# Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "this" {
    name                = var.cluster_name
    location            = var.location
    resource_group_name = var.rg_name
    dns_prefix          = var.dns_prefix
    node_resource_group = format("%s-%s", var.cluster_name, "rg")
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
            # outbound_ip_address_ids = [ azurerm_public_ip.this.id ]
            # outbound_ip_address_ids = azurerm_lb_backend_address_pool.this.backend_ip_configurations
        }
    }

    role_based_access_control {
        enabled = true
    }

    default_node_pool {
        name                = "default"
        vm_size             = "Standard_B2ms"
        os_disk_size_gb     = 30
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
        azurerm_subnet.this,
        azurerm_role_assignment.netcontribrole,
        # azurerm_public_ip.this,
        # azurerm_network_interface_backend_address_pool_association.this,
        # azurerm_subnet_route_table_association.this,
        # azurerm_network_interface_security_group_association.this,
        # azurerm_subnet_network_security_group_association.this,
        # azurerm_lb_outbound_rule.this,        
    ]

    tags = {
        Environment = "dev"
    }

    # # First provisioner: kubectl and helm install
    # provisioner "local-exec" {
    #     command = var.post_deploy_command
    #     on_failure = continue
    #     environment = {
    #         AKS_NAME   = var.cluster_name
    #         AKS_RG     = var.rg_name
    #     }
    # }

    # # Second provisioner: services install
    # provisioner "local-exec" {
    #     command = var.services_install_command
    #     on_failure = continue
    # }
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
