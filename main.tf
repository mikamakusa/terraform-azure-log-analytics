resource "azurerm_log_analytics_cluster" "this" {
  for_each            = { for a in var.cluster : a.name => a }
  location            = data.azurerm_resource_group.this.location
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name
  size_gb             = each.value.size_gb
  tags                = merge(var.tags, each.value.tags)

  identity {
    type         = each.value.identity_type
    identity_ids = each.value.identity_ids
  }
}

resource "azurerm_log_analytics_cluster_customer_managed_key" "this" {
  for_each                 = { for b in var.cluster : b.name => b if contains(keys(b), "managed_key") && b.managed_key != null }
  key_vault_key_id         = lookup(each.value, "key_vault_key_id")
  log_analytics_cluster_id = azurerm_log_analytics_cluster.this[each.key].id
}

resource "azurerm_log_analytics_workspace" "this" {
  for_each                                = { for c in var.workspace : c.name => c }
  location                                = data.azurerm_resource_group.this.location
  name                                    = each.value.name
  resource_group_name                     = data.azurerm_resource_group.this.name
  allow_resource_only_permissions         = each.value.allow_resource_only_permissions
  local_authentication_disabled           = each.value.local_authentication_disabled
  sku                                     = each.value.sku
  reservation_capacity_in_gb_per_day      = each.value.reservation_capacity_in_gb_per_day
  retention_in_days                       = each.value.retention_in_days
  daily_quota_gb                          = each.value.daily_quota_gb
  data_collection_rule_id                 = each.value.data_collection_rule_id
  cmk_for_query_forced                    = each.value.cmk_for_query_forced
  internet_ingestion_enabled              = each.value.internet_ingestion_enabled
  internet_query_enabled                  = each.value.internet_query_enabled
  immediate_data_purge_on_30_days_enabled = each.value.immediate_data_purge_on_30_days_enabled
  tags                                    = merge(var.tags, each.value.tags)

  identity {
    type         = each.value.identity_type
    identity_ids = each.value.identity_ids
  }
}

resource "azurerm_log_analytics_data_export_rule" "this" {
  for_each                = { for d in var.workspace : d.name => d if contains(keys(d), "export_rule") && d.export_rule != null }
  destination_resource_id = lookup(each.value, "destination_resource_id")
  name                    = lookup(each.value, "name")
  resource_group_name     = data.azurerm_resource_group.this.name
  table_names             = lookup(each.value, "table_names")
  workspace_resource_id   = azurerm_log_analytics_workspace.this[each.key].id
  enabled                 = lookup(each.value, "enabled")
}

resource "azurerm_log_analytics_datasource_windows_event" "this" {
  for_each            = { for d in var.workspace : d.name => d if contains(keys(d), "windows_event") && d.windows_event != null }
  event_log_name      = lookup(each.value, "event_log_name")
  event_types         = lookup(each.value, "event_types")
  name                = lookup(each.value, "name")
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_name      = azurerm_log_analytics_workspace.this[each.key].name
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "this" {
  for_each            = { for d in var.workspace : d.name => d if contains(keys(d), "windows_performance_counter") && d.windows_performance_counter != null }
  counter_name        = lookup(each.value, "counter_name")
  instance_name       = lookup(each.value, "instance_name")
  interval_seconds    = lookup(each.value, "interval_seconds")
  name                = lookup(each.value, "name")
  object_name         = lookup(each.value, "object_name")
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_name      = azurerm_log_analytics_workspace.this[each.key].name
}

resource "azurerm_log_analytics_linked_service" "this" {
  for_each            = { for d in var.workspace : d.name => d if contains(keys(d), "linked_service") && d.linked_service != null }
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this[each.key].id
  read_access_id      = lookup(each.value, "read_access_id")
  write_access_id     = lookup(each.value, "write_access_id")
}

resource "azurerm_log_analytics_linked_storage_account" "this" {
  for_each              = { for d in var.workspace : d.name => d if contains(keys(d), "linked_storage_account") && d.linked_storage_account != null }
  data_source_type      = lookup(each.value, "data_source_type")
  resource_group_name   = data.azurerm_resource_group.this.name
  storage_account_ids   = [lookup(each.value, "storage_account_ids")]
  workspace_resource_id = azurerm_log_analytics_workspace.this[each.key].id
}

resource "azurerm_log_analytics_query_pack" "this" {
  for_each            = { for c in var.query_pack : c.name => c }
  location            = data.azurerm_resource_group.this.location
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = merge(var.tags, each.value.tags)
}

resource "azurerm_log_analytics_query_pack_query" "this" {
  for_each                 = { for d in var.query_pack : d.name => d if contains(keys(d), "pack") && d.pack != null }
  body                     = lookup(each.value, "body")
  display_name             = lookup(each.value, "display_name")
  query_pack_id            = azurerm_log_analytics_query_pack.this[each.key].id
  name                     = lookup(each.value, "name")
  description              = lookup(each.value, "description")
  categories               = lookup(each.value, "categories")
  additional_settings_json = lookup(each.value, "additional_settings_json")
  resource_types           = lookup(each.value, "resource_types")
  solutions                = lookup(each.value, "solutions")
  tags                     = merge(var.tags, lookup(each.value, "tags"))
}

resource "azurerm_log_analytics_saved_search" "this" {
  for_each                   = { for d in var.workspace : d.name => d if contains(keys(d), "saved_search") && d.saved_search != null }
  category                   = lookup(each.value, "category")
  display_name               = lookup(each.value, "display_name")
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this[each.key].id
  name                       = lookup(each.value, "name")
  query                      = lookup(each.value, "query")
  function_alias             = lookup(each.value, "function_alias")
  function_parameters        = lookup(each.value, "function_parameters")
  tags                       = merge(var.tags, lookup(each.value, "tags"))
}

resource "azurerm_log_analytics_solution" "this" {
  for_each              = { for d in var.workspace : d.name => d if contains(keys(d), "solution") && d.solution != null }
  location              = data.azurerm_resource_group.this.location
  resource_group_name   = data.azurerm_resource_group.this.name
  solution_name         = lookup(each.value, "solution_name")
  workspace_name        = azurerm_log_analytics_workspace.this[each.key].name
  workspace_resource_id = azurerm_log_analytics_workspace.this[each.key].id
  tags                  = merge(var.tags, lookup(each.value, "tags"))

  plan {
    product   = lookup(each.value, "product")
    publisher = lookup(each.value, "publisher")
    promotion_code = lookup(each.value, "promotion_code")
  }
}

resource "azurerm_log_analytics_storage_insights" "this" {
  for_each             = { for d in var.workspace : d.name => d if contains(keys(d), "storage_insights") && d.storage_insights != null }
  name                 = lookup(each.value, "name")
  storage_account_id   = lookup(each.value, "storage_account_id")
  storage_account_key  = lookup(each.value, "storage_account_key")
  resource_group_name  = data.azurerm_resource_group.this.name
  workspace_id         = azurerm_log_analytics_workspace.this[each.key].id
  blob_container_names = lookup(each.value, "blob_container_names")
  table_names          = lookup(each.value, "table_names")
}



resource "azurerm_log_analytics_workspace_table" "this" {
  for_each                = { for d in var.workspace : d.name => d if contains(keys(d), "table") && d.table != null }
  name                    = lookup(each.value, "name")
  workspace_id            = azurerm_log_analytics_workspace.this[each.key].id
  plan                    = lookup(each.value, "plan")
  retention_in_days       = lookup(each.value, "retention_in_days")
  total_retention_in_days = lookup(each.value, "total_retention_in_days")
}