## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.115.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.115.0 |

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
| [azurerm_automation_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/automation_account) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.linked_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.storage_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>list(object({<br>    id            = number<br>    name          = string<br>    size_gb       = optional(number)<br>    tags          = optional(map(string))<br>    identity_type = optional(string)<br>    identity_ids  = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_customer_managed_key"></a> [cluster\_customer\_managed\_key](#input\_cluster\_customer\_managed\_key) | n/a | <pre>list(object({<br>    id         = number<br>    cluster_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_data_export_rule"></a> [data\_export\_rule](#input\_data\_export\_rule) | n/a | <pre>list(object({<br>    id                    = number<br>    name                  = string<br>    table_names           = list(string)<br>    workspace_resource_id = any<br>    enabled               = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_datasource_windows_event"></a> [datasource\_windows\_event](#input\_datasource\_windows\_event) | n/a | <pre>list(object({<br>    id             = number<br>    event_log_name = string<br>    event_types    = list(string)<br>    name           = string<br>    workspace_id   = any<br>  }))</pre> | `[]` | no |
| <a name="input_datasource_windows_performance_counter"></a> [datasource\_windows\_performance\_counter](#input\_datasource\_windows\_performance\_counter) | n/a | <pre>list(object({<br>    id               = number<br>    counter_name     = string<br>    instance_name    = string<br>    interval_seconds = number<br>    name             = string<br>    object_name      = string<br>    workspace_id     = any<br>  }))</pre> | `[]` | no |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | n/a | `string` | `null` | no |
| <a name="input_linked_service"></a> [linked\_service](#input\_linked\_service) | n/a | <pre>list(object({<br>    id              = number<br>    workspace_id    = any<br>    write_access_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_linked_storage_account"></a> [linked\_storage\_account](#input\_linked\_storage\_account) | n/a | <pre>list(object({<br>    id                    = number<br>    data_source_type      = string<br>    workspace_resource_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_linked_storage_account_name"></a> [linked\_storage\_account\_name](#input\_linked\_storage\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_query_pack"></a> [query\_pack](#input\_query\_pack) | n/a | <pre>list(object({<br>    id   = number<br>    name = string<br>    tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_query_pack_query"></a> [query\_pack\_query](#input\_query\_pack\_query) | n/a | <pre>list(object({<br>    id                       = number<br>    body                     = string<br>    display_name             = string<br>    query_pack_id            = any<br>    name                     = optional(string)<br>    description              = optional(string)<br>    categories               = optional(list(string))<br>    additional_settings_json = optional(string)<br>    resource_types           = optional(list(string))<br>    solutions                = optional(list(string))<br>    tags                     = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_saved_search"></a> [saved\_search](#input\_saved\_search) | n/a | <pre>list(object({<br>    id                         = number<br>    category                   = string<br>    display_name               = string<br>    log_analytics_workspace_id = any<br>    name                       = string<br>    query                      = string<br>    function_alias             = optional(string)<br>    function_parameters        = optional(list(string))<br>    tags                       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_solution"></a> [solution](#input\_solution) | n/a | <pre>list(object({<br>    id            = number<br>    solution_name = string<br>    workspace_id  = any<br>    tags          = optional(map(string))<br>    plan = list(object({<br>      product        = string<br>      publisher      = string<br>      promotion_code = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_storage_insight_account_name"></a> [storage\_insight\_account\_name](#input\_storage\_insight\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_storage_insights"></a> [storage\_insights](#input\_storage\_insights) | n/a | <pre>list(object({<br>    id                   = number<br>    name                 = string<br>    workspace_id         = any<br>    blob_container_names = optional(set(string))<br>    table_names          = optional(set(string))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | n/a | <pre>list(object({<br>    id                                      = number<br>    name                                    = string<br>    allow_resource_only_permissions         = optional(bool)<br>    local_authentication_disabled           = optional(bool)<br>    sku                                     = optional(string)<br>    reservation_capacity_in_gb_per_day      = optional(number)<br>    retention_in_days                       = optional(number)<br>    daily_quota_gb                          = optional(number)<br>    data_collection_rule_id                 = optional(string)<br>    cmk_for_query_forced                    = optional(bool)<br>    internet_ingestion_enabled              = optional(bool)<br>    internet_query_enabled                  = optional(bool)<br>    immediate_data_purge_on_30_days_enabled = optional(string)<br>    tags                                    = optional(map(string))<br>    identity_type                           = optional(string)<br>    identity_ids                            = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_workspace_table"></a> [workspace\_table](#input\_workspace\_table) | n/a | <pre>list(object({<br>    id                      = number<br>    name                    = string<br>    workspace_id            = any<br>    plan                    = optional(string)<br>    retention_in_days       = optional(number)<br>    total_retention_in_days = optional(number)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_data_export_rule_id"></a> [data\_export\_rule\_id](#output\_data\_export\_rule\_id) | n/a |
| <a name="output_data_export_rule_name"></a> [data\_export\_rule\_name](#output\_data\_export\_rule\_name) | n/a |
| <a name="output_datasource_windows_event_id"></a> [datasource\_windows\_event\_id](#output\_datasource\_windows\_event\_id) | n/a |
| <a name="output_datasource_windows_event_log_name"></a> [datasource\_windows\_event\_log\_name](#output\_datasource\_windows\_event\_log\_name) | n/a |
| <a name="output_datasource_windows_event_name"></a> [datasource\_windows\_event\_name](#output\_datasource\_windows\_event\_name) | n/a |
| <a name="output_datasource_windows_event_types"></a> [datasource\_windows\_event\_types](#output\_datasource\_windows\_event\_types) | n/a |
| <a name="output_datasource_windows_performance_counter_id"></a> [datasource\_windows\_performance\_counter\_id](#output\_datasource\_windows\_performance\_counter\_id) | n/a |
| <a name="output_datasource_windows_performance_counter_name"></a> [datasource\_windows\_performance\_counter\_name](#output\_datasource\_windows\_performance\_counter\_name) | n/a |
| <a name="output_linked_service_id"></a> [linked\_service\_id](#output\_linked\_service\_id) | n/a |
| <a name="output_linked_service_name"></a> [linked\_service\_name](#output\_linked\_service\_name) | n/a |
| <a name="output_linked_storage_account_id"></a> [linked\_storage\_account\_id](#output\_linked\_storage\_account\_id) | n/a |
| <a name="output_query_pack_id"></a> [query\_pack\_id](#output\_query\_pack\_id) | n/a |
| <a name="output_query_pack_name"></a> [query\_pack\_name](#output\_query\_pack\_name) | n/a |
| <a name="output_query_pack_query_id"></a> [query\_pack\_query\_id](#output\_query\_pack\_query\_id) | n/a |
| <a name="output_query_pack_query_name"></a> [query\_pack\_query\_name](#output\_query\_pack\_query\_name) | n/a |
| <a name="output_solution_id"></a> [solution\_id](#output\_solution\_id) | n/a |
| <a name="output_solution_name"></a> [solution\_name](#output\_solution\_name) | n/a |
| <a name="output_solution_plan"></a> [solution\_plan](#output\_solution\_plan) | n/a |
| <a name="output_storage_insights_id"></a> [storage\_insights\_id](#output\_storage\_insights\_id) | n/a |
| <a name="output_storage_insights_name"></a> [storage\_insights\_name](#output\_storage\_insights\_name) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | n/a |
| <a name="output_workspace_sku"></a> [workspace\_sku](#output\_workspace\_sku) | n/a |
| <a name="output_workspace_table_id"></a> [workspace\_table\_id](#output\_workspace\_table\_id) | n/a |
| <a name="output_workspace_table_name"></a> [workspace\_table\_name](#output\_workspace\_table\_name) | n/a |
