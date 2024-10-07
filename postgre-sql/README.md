<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6, < 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.71.0, <= 3.87.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.71.0, <= 3.87.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alerts"></a> [alerts](#module\_alerts) | ../terraform-azure-monitor-metric-alert | n/a |
| <a name="module_postgresql_mi_diagnostics"></a> [postgresql\_mi\_diagnostics](#module\_postgresql\_mi\_diagnostics) | ../terraform-azure-diagnostics-settings | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_postgresql_flexible_server.posgresflexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.postgresql_flexible_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [random_password.posgresql_password](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.kv_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_monitor_action_group.action_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_auth_enabled"></a> [ad\_auth\_enabled](#input\_ad\_auth\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_ag_name"></a> [ag\_name](#input\_ag\_name) | n/a | `string` | n/a | yes |
| <a name="input_ag_resource_group_name"></a> [ag\_resource\_group\_name](#input\_ag\_resource\_group\_name) | Name of the resource group for the action group | `string` | `null` | no |
| <a name="input_alert_definition"></a> [alert\_definition](#input\_alert\_definition) | If you wish to override the default alerts, define them here.  Set to {} if you wish to disable alerting | <pre>map(object({<br>    name_prefix              = string<br>    description              = string<br>    enabled                  = optional(bool)<br>    auto_mitigate            = optional(bool)<br>    frequency                = optional(string)<br>    window_size              = optional(string)<br>    severity                 = optional(number)<br>    target_resource_type     = optional(string)<br>    target_resource_location = optional(string)<br>    <br>    criteria = map(object({<br>      metric_namespace = string<br>      metric_name      = string<br>      aggregation      = string<br>      operator         = string<br>      threshold        = string<br><br>      dimension = optional(map(object({<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      })))<br>    }))<br>  }))</pre> | <pre>{<br>  "Active Connections": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Average",<br>        "metric_name": "active_connections",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "120"<br>      }<br>    },<br>    "description": "Alert if the number of active connections on the DB is greater than 120",<br>    "enabled": true,<br>    "name_prefix": "Active Connections",<br>    "severity": 3<br>  },<br>  "CPU Percent": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Average",<br>        "metric_name": "cpu_percent",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "90"<br>      }<br>    },<br>    "description": "Alert when the CPU percent is greater than 90%",<br>    "enabled": true,<br>    "name_prefix": "CPU Percent",<br>    "severity": 1<br>  },<br>  "Deadlocks": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Total",<br>        "metric_name": "deadlocks",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "1"<br>      }<br>    },<br>    "description": "Alert if the number of deadlocks detected on the DB is greater than 1",<br>    "enabled": true,<br>    "name_prefix": "IO Operations per second",<br>    "severity": 3<br>  },<br>  "Disk iops consumed percentage": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Average",<br>        "metric_name": "disk_iops_consumed_percentage",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "90"<br>      }<br>    },<br>    "description": "Alert if the disk iops concumed on the DB is greater than 90%",<br>    "enabled": true,<br>    "name_prefix": "Disk iops consumed percentage",<br>    "severity": 2<br>  },<br>  "Failed Connections": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Total",<br>        "metric_name": "connections_failed",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "5"<br>      }<br>    },<br>    "description": "Alert if the number of failed connections on the DB is greater than 5",<br>    "enabled": true,<br>    "name_prefix": "Failed Connections",<br>    "severity": 3<br>  },<br>  "IO Operations per second": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Average",<br>        "metric_name": "iops",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "450"<br>      }<br>    },<br>    "description": "Alert if the IO operations per second on the DB is greater than 450",<br>    "enabled": true,<br>    "name_prefix": "IO Operations per second",<br>    "severity": 2<br>  },<br>  "Is DB Alive": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Maximum",<br>        "metric_name": "is_db_alive",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "LessThan",<br>        "threshold": "1"<br>      }<br>    },<br>    "description": "Alert if the DB is down for whatever reason",<br>    "enabled": true,<br>    "name_prefix": "Is DB Alive",<br>    "severity": 1<br>  },<br>  "Memory Percent": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Average",<br>        "metric_name": "memory_percent",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "90"<br>      }<br>    },<br>    "description": "Alert if the memory on the DB is greater than 90%",<br>    "enabled": true,<br>    "name_prefix": "Memory Percent",<br>    "severity": 2<br>  },<br>  "Storage Percent": {<br>    "auto_mitigate": true,<br>    "criteria": {<br>      "default": {<br>        "aggregation": "Average",<br>        "metric_name": "storage_percent",<br>        "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>        "operator": "GreaterThan",<br>        "threshold": "90"<br>      }<br>    },<br>    "description": "Alert if the storage on the DB is greater than 90%",<br>    "enabled": true,<br>    "name_prefix": "Storage Percent",<br>    "severity": 2<br>  }<br>}</pre> | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | n/a | `number` | `31` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The subnet where you want the database created. The subnet must be delegated to Microsoft.DBforPostgreSQL/flexibleServers. | `string` | `null` | no |
| <a name="input_diagnostics_settings_name"></a> [diagnostics\_settings\_name](#input\_diagnostics\_settings\_name) | n/a | `string` | `null` | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | n/a | `bool` | `false` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | n/a | `bool` | `null` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_high_availability_mode"></a> [high\_availability\_mode](#input\_high\_availability\_mode) | n/a | `string` | `"SameZone"` | no |
| <a name="input_high_availability_standby_availability_zone"></a> [high\_availability\_standby\_availability\_zone](#input\_high\_availability\_standby\_availability\_zone) | n/a | `string` | `null` | no |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | n/a | `string` | `null` | no |
| <a name="input_key_vault_rg_name"></a> [key\_vault\_rg\_name](#input\_key\_vault\_rg\_name) | n/a | `string` | `null` | no |
| <a name="input_kv_secret_content_type"></a> [kv\_secret\_content\_type](#input\_kv\_secret\_content\_type) | (Optional) Specifies the content type for the Key Vault Secret. | `string` | `null` | no |
| <a name="input_kv_secret_expiration_date"></a> [kv\_secret\_expiration\_date](#input\_kv\_secret\_expiration\_date) | (Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `null` | no |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_posgresql_create_mode"></a> [posgresql\_create\_mode](#input\_posgresql\_create\_mode) | n/a | `string` | `null` | no |
| <a name="input_posgresql_server_name"></a> [posgresql\_server\_name](#input\_posgresql\_server\_name) | n/a | `string` | n/a | yes |
| <a name="input_posgresql_sku_name"></a> [posgresql\_sku\_name](#input\_posgresql\_sku\_name) | (Optional) The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B\_Standard\_B1ms, GP\_Standard\_D2s\_v3, MO\_Standard\_E4s\_v3). | `string` | `null` | no |
| <a name="input_posgresql_source_server_id"></a> [posgresql\_source\_server\_id](#input\_posgresql\_source\_server\_id) | n/a | `string` | `null` | no |
| <a name="input_posgresql_storage_mb"></a> [posgresql\_storage\_mb](#input\_posgresql\_storage\_mb) | Specifies the version of PostgreSQL to use. | `number` | `262144` | no |
| <a name="input_posgresql_version"></a> [posgresql\_version](#input\_posgresql\_version) | (Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13, 14, 15 and 16. Required when create\_mode is Default. | `number` | `14` | no |
| <a name="input_posgresql_zone"></a> [posgresql\_zone](#input\_posgresql\_zone) | n/a | `string` | `null` | no |
| <a name="input_postgres_admin"></a> [postgres\_admin](#input\_postgres\_admin) | PostgreSQL default admin. | `string` | `null` | no |
| <a name="input_postgresql_configurations"></a> [postgresql\_configurations](#input\_postgresql\_configurations) | PostgreSQL configurations to enable. | `map(string)` | `{}` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | The ID of the private DNS zone to create the PostgreSQL Flexible Server. The private DNS zone must end with the suffix .postgres.database.azure.com. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_user_assigned_identity_name"></a> [user\_assigned\_identity\_name](#input\_user\_assigned\_identity\_name) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgre_server_fqdn"></a> [postgre\_server\_fqdn](#output\_postgre\_server\_fqdn) | n/a |
| <a name="output_postgre_server_id"></a> [postgre\_server\_id](#output\_postgre\_server\_id) | n/a |
<!-- END_TF_DOCS -->
