terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.74.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.6.1"
    }

  }

  backend "azurerm" {
    resource_group_name  = "dep-pc-rg"
    storage_account_name = "deppctfstate"
    container_name       = "pcc"
    key                  = "shared.tfstate"
  }
}