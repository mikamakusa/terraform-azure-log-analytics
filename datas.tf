data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "this" {
  count               = var.key_vault_name ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault_key" "this" {
  count        = (var.key_vault_name && var.key_vault_key_name) ? 1 : 0
  key_vault_id = data.azurerm_key_vault.this.id
  name         = var.key_vault_key_name
}

data "azurerm_storage_account" "this" {
  count               = var.storage_account_name ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_automation_account" "this" {
  count               = var.automation_account_name ? 1 : 0
  name                = var.automation_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}