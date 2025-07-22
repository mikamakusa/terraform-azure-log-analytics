## CLUSTER ##

output "cluster" {
  value = {
    for a in azurerm_log_analytics_cluster.this : a => {
      id         = a.id
      name       = a.name
      tags       = a.tags
      cluster_id = a.cluster_id
    }
  }
}

## DATA EXPORT RULE ##

output "export_rule" {
  value = {
    for a in azurerm_log_analytics_data_export_rule.this : a => {
      id             = a.id
      export_rule_id = a.export_rule_id
    }
  }
}

## DATA SOURCES ##

output "windows_event" {
  value = {
    for a in azurerm_log_analytics_datasource_windows_event.this : a => {
      id = a.id
    }
  }
}

## LINKED SERVICE ##

output "linked_service" {
  value = {
    for a in azurerm_log_analytics_linked_service.this : a => {
      id   = a.id
      name = a.name
    }
  }
}

## LINKED STORAGE ACCOUNT ##

output "linked_storage_account" {
  value = {
    for a in azurerm_log_analytics_linked_storage_account.this : a => {
      id = a.id
    }
  }
}

## QUERY PACK ##

output "query_pack" {
  value = {
    for a in azurerm_log_analytics_query_pack.this : a => {
      id = a.id
    }
  }
}

## SOLUTION ##

output "solution" {
  value = {
    for a in azurerm_log_analytics_solution.this : a => {
      id = a.id
    }
  }
}

## STORAGE INSIGHTS ##

output "storage_insights" {
  value = {
    for a in azurerm_log_analytics_storage_insights.this : a => {
      id = a.id
    }
  }
}

## WORKSPACE ##

output "workspace" {
  value = {
    for a in azurerm_log_analytics_workspace.this : a => {
      id                                      = a.id
      name                                    = a.name
      sku                                     = a.sku
      allow_resource_only_permissions         = a.allow_resource_only_permissions
      cmk_for_query_forced                    = a.cmk_for_query_forced
      daily_quota_gb                          = a.daily_quota_gb
      data_collection_rule_id                 = a.data_collection_rule_id
      immediate_data_purge_on_30_days_enabled = a.immediate_data_purge_on_30_days_enabled
      internet_ingestion_enabled              = a.internet_ingestion_enabled
      internet_query_enabled                  = a.internet_query_enabled
      local_authentication_disabled           = a.local_authentication_disabled
      primary_shared_key                      = a.primary_shared_key
      secondary_shared_key                    = a.secondary_shared_key
      workspace_id                            = a.workspace_id
    }
  }
}