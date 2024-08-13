resource "azurerm_log_analytics_cluster" "this" {
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.cluster[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  size_gb             = lookup(var.cluster[count.index], "size_gb")
  tags                = merge(var.tags, lookup(var.cluster[count.index], "tags"))

  dynamic "identity" {
    for_each = lookup(var.cluster[count.index], "identity_type") == null ? [] : ["identity"]
    content {
      type         = lookup(var.cluster[count.index], "identity_type")
      identity_ids = lookup(var.cluster[count.index], "identity_ids")
    }
  }
}

resource "azurerm_log_analytics_cluster_customer_managed_key" "this" {
  count                    = length(var.cluster) == 0 ? 0 : length(var.cluster_customer_managed_key)
  key_vault_key_id         = data.azurerm_key_vault_key.this.id
  log_analytics_cluster_id = try(element(azurerm_log_analytics_cluster.this.*.id, lookup(var.cluster_customer_managed_key[count.index], "cluster_id")))
}

resource "azurerm_log_analytics_data_export_rule" "this" {
  count                   = length(var.workspace) == 0 ? 0 : length(var.data_export_rule)
  destination_resource_id = data.azurerm_storage_account.this.id
  name                    = lookup(var.data_export_rule[count.index], "name")
  resource_group_name     = data.azurerm_resource_group.this.name
  table_names             = lookup(var.data_export_rule[count.index], "table_names")
  workspace_resource_id   = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_export_rule[count.index], "workspace_resource_id")))
  enabled                 = lookup(var.data_export_rule[count.index], "enabled")
}

resource "azurerm_log_analytics_datasource_windows_event" "this" {
  count               = length(var.workspace) == 0 ? 0 : length(var.datasource_windows_event)
  event_log_name      = lookup(var.datasource_windows_event[count.index], "event_log_name")
  event_types         = lookup(var.datasource_windows_event[count.index], "event_types")
  name                = lookup(var.datasource_windows_event[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_name      = try(element(azurerm_log_analytics_workspace.this.*.name, lookup(var.datasource_windows_event[count.index], "workspace_id")))
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "this" {
  count               = length(var.workspace) == 0 ? 0 : length(var.datasource_windows_performance_counter)
  counter_name        = lookup(var.datasource_windows_performance_counter[count.index], "counter_name")
  instance_name       = lookup(var.datasource_windows_performance_counter[count.index], "instance_name")
  interval_seconds    = lookup(var.datasource_windows_performance_counter[count.index], "interval_seconds")
  name                = lookup(var.datasource_windows_performance_counter[count.index], "name")
  object_name         = lookup(var.datasource_windows_performance_counter[count.index], "object_name")
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_name      = try(element(azurerm_log_analytics_workspace.this.*.name, lookup(var.datasource_windows_performance_counter[count.index], "workspace_id")))
}

resource "azurerm_log_analytics_linked_service" "this" {
  count               = length(var.workspace) == 0 ? 0 : length(var.linked_service)
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_id        = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.linked_service[count.index], "workspace_id")))
  read_access_id      = data.azurerm_automation_account.this.id
  write_access_id     = lookup(var.linked_service[count.index], "write_access_id")
}

resource "azurerm_log_analytics_linked_storage_account" "this" {
  count                 = length(var.workspace) == 0 ? 0 : length(var.linked_storage_account)
  data_source_type      = lookup(var.linked_storage_account[count.index], "data_source_type")
  resource_group_name   = data.azurerm_resource_group.this.name
  storage_account_ids   = [data.azurerm_storage_account.linked_storage.id]
  workspace_resource_id = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.linked_storage_account[count.index], "workspace_id")))
}

resource "azurerm_log_analytics_query_pack" "this" {
  count               = length(var.query_pack)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.query_pack[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = merge(var.tags, lookup(var.query_pack[count.index], "tags"))
}

resource "azurerm_log_analytics_query_pack_query" "this" {
  count                    = length(var.query_pack) == 0 ? 0 : length(var.query_pack_query)
  body                     = lookup(var.query_pack_query[count.index], "body")
  display_name             = lookup(var.query_pack_query[count.index], "display_name")
  query_pack_id            = try(element(azurerm_log_analytics_query_pack.this.*.id, lookup(var.query_pack_query[count.index], "query_pack_id")))
  name                     = lookup(var.query_pack_query[count.index], "name")
  description              = lookup(var.query_pack_query[count.index], "description")
  categories               = lookup(var.query_pack_query[count.index], "categories")
  additional_settings_json = lookup(var.query_pack_query[count.index], "additional_settings_json")
  resource_types           = lookup(var.query_pack_query[count.index], "resource_types")
  solutions                = lookup(var.query_pack_query[count.index], "solutions")
  tags                     = merge(var.tags, lookup(var.query_pack_query[count.index], "tags"))
}

resource "azurerm_log_analytics_saved_search" "this" {
  count                      = length(var.workspace) == 0 ? 0 : length(var.saved_search)
  category                   = lookup(var.saved_search[count.index], "category")
  display_name               = lookup(var.saved_search[count.index], "display_name")
  log_analytics_workspace_id = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.saved_search[count.index], "workspace_id")))
  name                       = lookup(var.saved_search[count.index], "name")
  query                      = lookup(var.saved_search[count.index], "query")
  function_alias             = lookup(var.saved_search[count.index], "function_alias")
  function_parameters        = lookup(var.saved_search[count.index], "function_parameters")
  tags                       = merge(var.tags, lookup(var.saved_search[count.index], "tags"))
}

resource "azurerm_log_analytics_solution" "this" {
  count                 = length(var.workspace) == 0 ? 0 : length(var.solution)
  location              = data.azurerm_resource_group.this.location
  resource_group_name   = data.azurerm_resource_group.this.name
  solution_name         = lookup(var.solution[count.index], "solution_name")
  workspace_name        = try(element(azurerm_log_analytics_workspace.this.*.name, lookup(var.solution[count.index], "workspace_id")))
  workspace_resource_id = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.solution[count.index], "workspace_id")))
  tags                  = merge(var.tags, lookup(var.solution[count.index], "tags"))

  dynamic "plan" {
    for_each = lookup(var.solution[count.index], "plan")
    content {
      product        = lookup(plan.value, "product")
      publisher      = lookup(plan.value, "publisher")
      promotion_code = lookup(plan.value, "promotion_code")
    }
  }
}

resource "azurerm_log_analytics_storage_insights" "this" {
  count                = length(var.workspace) == 0 ? 0 : length(var.storage_insights)
  name                 = lookup(var.storage_insights[count.index], "name")
  storage_account_id   = data.azurerm_storage_account.storage_insights.id
  storage_account_key  = data.azurerm_storage_account.storage_insights.primary_access_key
  resource_group_name  = data.azurerm_resource_group.this.name
  workspace_id         = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.storage_insights[count.index], "workspace_id")))
  blob_container_names = lookup(var.storage_insights[count.index], "blob_container_names")
  table_names          = lookup(var.storage_insights[count.index], "table_names")
}

resource "azurerm_log_analytics_workspace" "this" {
  count                                   = length(var.workspace)
  location                                = data.azurerm_resource_group.this.location
  name                                    = lookup(var.workspace[count.index], "name")
  resource_group_name                     = data.azurerm_resource_group.this.name
  allow_resource_only_permissions         = lookup(var.workspace[count.index], "allow_resource_only_permissions")
  local_authentication_disabled           = lookup(var.workspace[count.index], "local_authentication_disabled")
  sku                                     = lookup(var.workspace[count.index], "sku")
  reservation_capacity_in_gb_per_day      = lookup(var.workspace[count.index], "reservation_capacity_in_gb_per_day")
  retention_in_days                       = lookup(var.workspace[count.index], "retention_in_days")
  daily_quota_gb                          = lookup(var.workspace[count.index], "daily_quota_gb")
  data_collection_rule_id                 = lookup(var.workspace[count.index], "data_collection_rule_id")
  cmk_for_query_forced                    = lookup(var.workspace[count.index], "cmk_for_query_forced")
  internet_ingestion_enabled              = lookup(var.workspace[count.index], "internet_ingestion_enabled")
  internet_query_enabled                  = lookup(var.workspace[count.index], "internet_query_enabled")
  immediate_data_purge_on_30_days_enabled = lookup(var.workspace[count.index], "immediate_data_purge_on_30_days_enabled")
  tags                                    = merge(var.tags, lookup(var.workspace[count.index], "tags"))

  dynamic "identity" {
    for_each = lookup(var.workspace[count.index], "identity_type") != null ? ["identity"] : []
    content {
      type         = lookup(var.workspace[count.index], "identity_type")
      identity_ids = lookup(var.workspace[count.index], "identity_type") == "UserAssigned" ? lookup(var.workspace[count.index], "identity_ids") : null
    }
  }
}

resource "azurerm_log_analytics_workspace_table" "this" {
  count                   = length(var.workspace) == 0 ? 0 : length(var.workspace_table)
  name                    = lookup(var.workspace_table[count.index], "name")
  workspace_id            = try(element(azurerm_log_analytics_workspace.this.*.id, lookup(var.workspace_table[count.index], "workspace_id")))
  plan                    = lookup(var.workspace_table[count.index], "plan")
  retention_in_days       = lookup(var.workspace_table[count.index], "retention_in_days")
  total_retention_in_days = lookup(var.workspace_table[count.index], "total_retention_in_days")
}