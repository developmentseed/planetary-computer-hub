provider "azurerm" {
  features {}
  subscription_id = "b91e3470-ff50-4ea0-a0c7-b57006093805"
}

provider "helm" {
  # https://dev.to/danielepolencic/getting-started-with-terraform-and-kubernetes-on-azure-aks-3l4d
  debug = true
  kubernetes {
    host                   = azurerm_kubernetes_cluster.pc_compute.kube_config[0].host
    client_key             = base64decode(azurerm_kubernetes_cluster.pc_compute.kube_config[0].client_key)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.pc_compute.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.pc_compute.kube_config[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.pc_compute.kube_config[0].host
  client_key             = base64decode(azurerm_kubernetes_cluster.pc_compute.kube_config[0].client_key)
  client_certificate     = base64decode(azurerm_kubernetes_cluster.pc_compute.kube_config[0].client_certificate)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.pc_compute.kube_config[0].cluster_ca_certificate)
}
