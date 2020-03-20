# Kubernetes cluster with networking options

Terraform files and scripts to generate a Kubernetes cluster with hands on networking 

This generates:
    - A resource group
    - A static IP
    - A vnet and a subnet
    - A route table associated to the subnet
    - A network security group associated to the subnet
    - A Kubernetes cluster
    - A second node pool

Notes:
    - Bug: The NSG is duplicated as the network interface is missing


Usage:

```
az ad sp create-for-rbac --skip-assignment --name the-name-of-your-principal

export TF_VARS_client_id = "..."
export TF_VARS_client_secret = "..."

terraform init

terraform apply

```