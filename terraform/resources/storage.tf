resource "azurerm_storage_account" "pc-compute" {
  name                     = "${replace(local.prefix, "-", "")}storage"
  resource_group_name      = azurerm_resource_group.pc_compute.name
  location                 = azurerm_resource_group.pc_compute.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "pc-compute" {
  name                 = "driven-data"
  storage_account_name = azurerm_storage_account.pc-compute.name
  quota                = 100
}

resource "azurerm_storage_account" "private" {
  name                     = "deppcprivatestorage"
  resource_group_name      = azurerm_resource_group.pc_compute.name
  location                 = azurerm_resource_group.pc_compute.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_account" "public" {
  name                      = "deppcpublicstorage"
  resource_group_name      = azurerm_resource_group.pc_compute.name
  location                 = azurerm_resource_group.pc_compute.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  allow_blob_public_access  = true
  is_hns_enabled            = true
  enable_https_traffic_only = false

  network_rules {
    default_action = "Allow"
  }
}

resource "azurerm_storage_container" "output" {
  name                  = "output"
  storage_account_name  = azurerm_storage_account.public.name
  container_access_type = "blob"
}
