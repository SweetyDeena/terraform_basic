terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
  common_tags = {
    Owner   = "Development"
    service = "Back-end"
  }
}

resource "azurerm_resource_group" "demo-rg" {
  name     = "demoResource"
  location = "West Europe"
  tags     = local.common_tags
}

resource "azurerm_storage_account" "demo-store" {
  name                     = "storeddemo11"
  location                 = azurerm_resource_group.demo-rg.location
  resource_group_name      = azurerm_resource_group.demo-rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

resource "azurerm_storage_container" "demostore" {
  name                  = "demostore"
  storage_account_name  = azurerm_storage_account.demo-store.name
  container_access_type = "blob"
}

resource "azurerm_virtual_network" "demo-vn" {
  name                = "demo-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demo-rg.location
  resource_group_name = azurerm_resource_group.demo-rg.name
  tags                = local.common_tags
}


