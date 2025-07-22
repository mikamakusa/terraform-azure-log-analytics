provider "azurerm" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-az-1"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "log_analytics_cluster" {
  source              = "../../"
  resource_group_name = "rg-az-1"
  cluster = [{
    name          = "example-cluster"
    identity_type = "SystemAssigned"
  }]
  workspace = [{
    name              = "example"
    sku               = "PerGB2018"
    retention_in_days = 30
    export_rule = [{
      name                    = "dataExport1"
      destination_resource_id = azurerm_storage_account.example.id
      table_names             = ["Heartbeat"]
      enabled                 = true
    }]
    windows_event = [{
      name           = "example-lad-wpc"
      event_log_name = "Application"
      event_types    = ["Error"]
    }]
    solution = [{
      solution_name = "ContainerInsights"
      publisher     = "Microsoft"
      product       = "OMSGallery/ContainerInsights"
    }]
  }]
}