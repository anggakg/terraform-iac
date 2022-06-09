terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = var.rg_name
        storage_account_name = var.storage_account_name
        container_name       = var.container_name
        key                  = var.key
    }
}