## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.115.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_cluster) | resource |
| [azurerm_log_analytics_cluster_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_cluster_customer_managed_key) | resource |
| [azurerm_log_analytics_data_export_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_data_export_rule) | resource |
| [azurerm_log_analytics_datasource_windows_event.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_datasource_windows_event) | resource |
| [azurerm_log_analytics_datasource_windows_performance_counter.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_datasource_windows_performance_counter) | resource |
| [azurerm_log_analytics_linked_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_service) | resource |
| [azurerm_log_analytics_linked_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_storage_account) | resource |
| [azurerm_log_analytics_query_pack.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_query_pack) | resource |
| [azurerm_log_analytics_query_pack_query.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_query_pack_query) | resource |
| [azurerm_log_analytics_saved_search.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_saved_search) | resource |
| [azurerm_log_analytics_solution.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_storage_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_storage_insights) | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_log_analytics_workspace_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace_table) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>list(object({<br/>    name          = string<br/>    size_gb       = optional(number)<br/>    tags          = optional(map(string))<br/>    identity_type = optional(string)<br/>    identity_ids  = optional(list(string))<br/>    managed_key   = optional(object({<br/>      key_vault_key_id = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_query_pack"></a> [query\_pack](#input\_query\_pack) | n/a | <pre>list(object({<br/>    id   = number<br/>    name = string<br/>    tags = optional(map(string))<br/>    pack = optional(list(object({<br/>      body                     = string<br/>      display_name             = string<br/>      name                     = optional(string)<br/>      description              = optional(string)<br/>      categories               = optional(list(string))<br/>      additional_settings_json = optional(string)<br/>      resource_types           = optional(list(string))<br/>      solutions                = optional(list(string))<br/>      tags                     = optional(map(string))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | n/a | <pre>list(object({<br/>    name                                    = string<br/>    allow_resource_only_permissions         = optional(bool)<br/>    local_authentication_disabled           = optional(bool)<br/>    sku                                     = optional(string)<br/>    reservation_capacity_in_gb_per_day      = optional(number)<br/>    retention_in_days                       = optional(number)<br/>    daily_quota_gb                          = optional(number)<br/>    data_collection_rule_id                 = optional(string)<br/>    cmk_for_query_forced                    = optional(bool)<br/>    internet_ingestion_enabled              = optional(bool)<br/>    internet_query_enabled                  = optional(bool)<br/>    immediate_data_purge_on_30_days_enabled = optional(string)<br/>    tags                                    = optional(map(string))<br/>    identity_type                           = optional(string)<br/>    identity_ids                            = optional(list(string))<br/>    export_rule = optional(list(object({<br/>      name                    = string<br/>      table_names             = list(string)<br/>      enabled                 = optional(bool)<br/>      destination_resource_id = string<br/>    })))<br/>    windows_event = optional(list(object({<br/>      event_log_name = string<br/>      event_types    = list(string)<br/>      name           = string<br/>    })))<br/>    windows_performance_counter = optional(list(object({<br/>      counter_name     = string<br/>      instance_name    = string<br/>      interval_seconds = number<br/>      name             = string<br/>      object_name      = string<br/>    })))<br/>    linked_service = optional(list(object({<br/>      write_access_id = string<br/>      read_access_id  = string<br/>    })))<br/>    linked_storage_account = optional(list(object({<br/>      data_source_type    = string<br/>      storage_account_ids = string<br/>    })))<br/>    saved_search = optional(list(object({<br/>      category            = string<br/>      display_name        = string<br/>      name                = string<br/>      query               = string<br/>      function_alias      = optional(string)<br/>      function_parameters = optional(list(string))<br/>      tags                = optional(map(string))<br/>    })))<br/>    solution = optional(list(object({<br/>      solution_name  = string<br/>      tags           = optional(map(string))<br/>      product        = string<br/>      publisher      = string<br/>      promotion_code = optional(string)<br/>    })))<br/>    storage_insights = optional(list(object({<br/>      name                 = string<br/>      blob_container_names = optional(set(string))<br/>      table_names          = optional(set(string))<br/>    })))<br/>    table = optional(list(object({<br/>      name                    = string<br/>      plan                    = optional(string)<br/>      retention_in_days       = optional(number)<br/>      total_retention_in_days = optional(number)<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | n/a |
| <a name="output_export_rule"></a> [export\_rule](#output\_export\_rule) | n/a |
| <a name="output_linked_service"></a> [linked\_service](#output\_linked\_service) | n/a |
| <a name="output_linked_storage_account"></a> [linked\_storage\_account](#output\_linked\_storage\_account) | n/a |
| <a name="output_query_pack"></a> [query\_pack](#output\_query\_pack) | n/a |
| <a name="output_solution"></a> [solution](#output\_solution) | n/a |
| <a name="output_storage_insights"></a> [storage\_insights](#output\_storage\_insights) | n/a |
| <a name="output_windows_event"></a> [windows\_event](#output\_windows\_event) | n/a |
| <a name="output_workspace"></a> [workspace](#output\_workspace) | n/a |
