provider "azurerm" {}

module "log_analytics_cluster" {
  source              = "../../"
  resource_group_name = "rg-az-1"
  cluster = [{
    name          = "example-cluster"
    identity_type = "SystemAssigned"
  }]
}