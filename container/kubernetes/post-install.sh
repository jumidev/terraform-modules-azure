#!/bin/bash

set -e

# terraform import azurerm_resource_group.aks-rg /subscriptions/ec732e25-fe05-48d6-8644-d8e3a6aaed2f/resourceGroups/test
# terraform import azurerm_resource_group.aks-rg /subscriptions/ec732e25-fe05-48d6-8644-d8e3a6aaed2f/resourceGroups/test

echo "Getting AKS credentials..."
az aks get-credentials -n $AKS_NAME -g $AKS_RG --overwrite-existing

echo "Creating service account and cluster role binding for Tiller..."
kubectl create serviceaccount -n kube-system tiller
kubectl create clusterrolebinding tiller --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

echo "Initializing Helm..."
# helm init --service-account tiller

echo "Helm has been installed."
