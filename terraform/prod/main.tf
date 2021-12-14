module "resources" {
  source      = "../resources"
  environment = "prod"
  region      = "West Europe"

  pc_resources_rg = "dep-pc-rg"
  pc_resources_kv = "dep-pc-kv"

  # AKS ----------------------------------------------------------------------
  kubernetes_version = "1.20.9"
  # 8GB of RAM, 4 CPU cores, ssd base disk
  core_vm_size              = "Standard_E4s_v3"
  user_pool_min_count       = 1
  cpu_worker_pool_min_count = 1

  # Logs ---------------------------------------------------------------------
  workspace_id = "225cedbd199c55da"

  # DaskHub ------------------------------------------------------------------
  dns_label                 = "dep-pccompute"
  jupyterhub_host           = "dep-pccompute.westeurope.cloudapp.azure.com"
  user_placeholder_replicas = 1
  stac_url                  = "https://planetarycomputer.microsoft.com/api/stac/v1/"

  jupyterhub_singleuser_image_name = "mcr.microsoft.com/planetary-computer/python"
  jupyterhub_singleuser_image_tag  = "2021.11.30.0"
  python_image                     = "mcr.microsoft.com/planetary-computer/python:2021.11.30.0"
  r_image                          = "mcr.microsoft.com/planetary-computer/r:2021.11.19.0"
  gpu_pytorch_image                = "mcr.microsoft.com/planetary-computer/gpu-pytorch:2021.11.30.0"
  gpu_tensorflow_image             = "mcr.microsoft.com/planetary-computer/gpu-tensorflow:2021.11.30.0"
  qgis_image                       = "mcr.microsoft.com/planetary-computer/qgis:3.18.0"

  kbatch_proxy_url = "http://dhub-prod-kbatch-proxy.prod.svc.cluster.local"
}


output "resources" {
  value     = module.resources
  sensitive = true
}