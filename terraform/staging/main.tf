module "resources" {
  source      = "../resources"
  environment = "staging"
  region      = "West Europe"
  # subscription = "Planetary Computer"

  # AKS ----------------------------------------------------------------------
  kubernetes_version = "1.21.2"
  # 2GiB of RAM, 1 CPU core
  core_vm_size = "Standard_A2_v2"

  # Logs ---------------------------------------------------------------------
  workspace_id = "83dcaf36e047a90f"

  # DaskHub ------------------------------------------------------------------
  dns_label                        = "pcc-staging"
  jupyterhub_host                  = "pcc-staging.westeurope.cloudapp.azure.com"
  user_placeholder_replicas        = 0
  stac_url                         = "https://planetarycomputer-staging.microsoft.com/api/stac/v1/"
  jupyterhub_singleuser_image_name = "mcr.microsoft.com/planetary-computer/python"
  jupyterhub_singleuser_image_tag  = "2021.08.30.0"
  python_image                     = "mcr.microsoft.com/planetary-computer/python:2021.08.30.0"
  r_image                          = "mcr.microsoft.com/planetary-computer/r:2021.08.24.0"
  gpu_pytorch_image                = "mcr.microsoft.com/planetary-computer/gpu-pytorch:2021.08.30.0"
  qgis_image                       = "pcccr.azurecr.io/planetary-computer/qgis:3.18.0"

}

terraform {
  backend "azurerm" {
    resource_group_name  = "pc-manual-resources"
    storage_account_name = "pctfstate"
    container_name       = "pcc"
    key                  = "staging.tfstate"
  }
}

output "resources" {
  value     = module.resources
  sensitive = true
}