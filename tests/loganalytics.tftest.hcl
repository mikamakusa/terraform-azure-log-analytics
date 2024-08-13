run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "create_log_analytics_worspace" {
  command = [plan,apply]

  variables {
    resource_group_name           = "rg-test"
    key_vault_name                = "kv-test"
    key_vault_key_name            = "key-test"
    storage_account_name          = "storage_1"
    automation_account_name       = "test-auto"
    linked_storage_account_name   = "storage_2"
    storage_insight_account_name  = "storage_3"
    workspace = [{
      id                  = 0
      name                = "acctest-01"
      sku                 = "PerGB2018"
      retention_in_days   = 30
    }]
    cluster = [{
      id            = 0
      name          = "example-cluster"
      identity_type = "SystemAssigned"
    }]
    cluster_customer_managed_key = [{
      id          = 0
      cluster_id  = 0
    }]
    data_export_rule = [{
      id                      = 0
      workspace_id            = 0
      name                    = "dataExport1"
      table_names             = ["Heartbeat"]
      enabled                 = true
    }]
    datasource_windows_event = [{
      id                = 0
      name              = "example-lad-wpc"
      workspace_id      = 0
      event_log_name    = "Application"
      event_types       = ["Error"]
    }]
    datasource_windows_performance_counter = [{
      id                  = 0
      name                = "example-lad-wpc"
      workspace_id        = 0
      object_name         = "CPU"
      instance_name       = "*"
      counter_name        = "CPU"
      interval_seconds    = 10
    }]
    linked_service = [{
      id            = 0
      workspace_id  = 0
    }]
    linked_storage_account = [{
      id                    = 0
      data_source_type      = "CustomLogs"
      workspace_id          = 0
    }]
    query_pack = [{
      id = 0
      name = "example-qp"
    }]
    query_pack_query = [{
      id            = 0
      name          = "19952bc3-0bf9-49eb-b713-6b80e7a41847"
      query_pack_id = 0
      body          = "let newExceptionsTimeRange = 1d;\nlet timeRangeToCheckBefore = 7d;\nexceptions\n| where timestamp < ago(timeRangeToCheckBefore)\n| summarize count() by problemId\n| join kind= rightanti (\nexceptions\n| where timestamp >= ago(newExceptionsTimeRange)\n| extend stack = tostring(details[0].rawStack)\n| summarize count(), dcount(user_AuthenticatedId), min(timestamp), max(timestamp), any(stack) by problemId  \n) on problemId \n| order by  count_ desc\n"
      display_name  = "Exceptions - New in the last 24 hours"
    }]
    saved_search = [{
      id           = 0
      name         = "exampleSavedSearch"
      workspace_id = 0
      category     = "exampleCategory"
      display_name = "exampleDisplayName"
      query        = "exampleQuery"
    }]
    solution = [{
      id                  = 0
      solution_name       = "ContainerInsights"
      workspace_id        = 0
      plan = [
        {
          publisher = "Microsoft"
          product   = "OMSGallery/ContainerInsights"
        }
      ]
    }]
    storage_insights = [{
      id            = 0
      name          = "example-storageinsightconfig"
      workspace_id  = 0
    }]
    workspace_table = [{
      id                      = 0
      workspace_id            = 0
      name                    = "AppMetrics"
      retention_in_days       = 60
      total_retention_in_days = 180
    }]
  }
}