resource azurerm_resource_group default {
  location = "uksouth"
  name     = "tf-rg"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "tf-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "tf-k8s"
  kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
}

resource "ogc_cluster" "cluster" {
  display_name                 = "tf-aks-cluster"
  permit_privileged_containers = false
  description                  = "cluster created by terraform"
  labels                       = {
    key = "value"
  }
  projects = ["5b205994-2bce-40c6-9e9d-d2175d3ddd6a"]

  kubernetes_config {
    host                   = azurerm_kubernetes_cluster.main.kube_config.0.host
    username               = azurerm_kubernetes_cluster.main.kube_config.0.username
    password               = azurerm_kubernetes_cluster.main.kube_config.0.password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
  }
}