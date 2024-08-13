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