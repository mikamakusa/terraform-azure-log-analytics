## CLUSTER ##

output "cluster_id" {
  value = try(
    azurerm_log_analytics_cluster.this.*.id
  )
}

output "cluster_name" {
  value = try(
    azurerm_log_analytics_cluster.this.*.name
  )
}

## DATA EXPORT RULE ##

output "data_export_rule_id" {
  value = try(
    azurerm_log_analytics_data_export_rule.this.*.id
  )
}

output "data_export_rule_name" {
  value = try(
    azurerm_log_analytics_data_export_rule.this.*.name
  )
}

## DATA SOURCES ##

output "datasource_windows_event_id" {
  value = try(
    azurerm_log_analytics_datasource_windows_event.this.*.id
  )
}

output "datasource_windows_event_name" {
  value = try(
    azurerm_log_analytics_datasource_windows_event.this.*.name
  )
}

output "datasource_windows_event_log_name" {
  value = try(
    azurerm_log_analytics_datasource_windows_event.this.*.event_log_name
  )
}

output "datasource_windows_event_types" {
  value = try(azurerm_log_analytics_datasource_windows_event.this.*.event_types)
}

output "datasource_windows_performance_counter_id" {
  value = try(
    azurerm_log_analytics_datasource_windows_performance_counter.this.*.id
  )
}

output "datasource_windows_performance_counter_name" {
  value = try(
    azurerm_log_analytics_datasource_windows_performance_counter.this.*.name
  )
}

## LINKED SERVICE ##

output "linked_service_id" {
  value = try(
    azurerm_log_analytics_linked_service.this.*.id
  )
}

output "linked_service_name" {
  value = try(
    azurerm_log_analytics_linked_service.this.*.name
  )
}

## LINKED STORAGE ACCOUNT ##

output "linked_storage_account_id" {
  value = try(
    azurerm_log_analytics_linked_storage_account.this.*.id
  )
}

## QUERY PACK ##

output "query_pack_id" {
  value = try(
    azurerm_log_analytics_query_pack.this.*.id
  )
}

output "query_pack_name" {
  value = try(
    azurerm_log_analytics_query_pack.this.*.name
  )
}

output "query_pack_query_name" {
  value = try(
    azurerm_log_analytics_query_pack_query.this.*.name
  )
}

output "query_pack_query_id" {
  value = try(
    azurerm_log_analytics_query_pack_query.this.*.id
  )
}

## SOLUTION ##

output "solution_id" {
  value = try(
    azurerm_log_analytics_solution.this.*.id
  )
}

output "solution_name" {
  value = try(
    azurerm_log_analytics_solution.this.*.solution_name
  )
}

output "solution_plan" {
  value = try(
    azurerm_log_analytics_solution.this.*.plan
  )
}

## STORAGE INSIGHTS ##

output "storage_insights_id" {
  value = try(
    azurerm_log_analytics_storage_insights.this.*.id
  )
}

output "storage_insights_name" {
  value = try(
    azurerm_log_analytics_storage_insights.this.*.name
  )
}

## WORKSPACE ##

output "workspace_id" {
  value = try(
    azurerm_log_analytics_workspace.this.*.id
  )
}

output "workspace_name" {
  value = try(
    azurerm_log_analytics_workspace.this.*.name
  )
}

output "workspace_sku" {
  value = try(
    azurerm_log_analytics_workspace.this.*.sku
  )
}

output "workspace_table_id" {
  value = try(
    azurerm_log_analytics_workspace_table.this.*.id
  )
}

output "workspace_table_name" {
  value = try(
    azurerm_log_analytics_workspace_table.this.*.name
  )
}