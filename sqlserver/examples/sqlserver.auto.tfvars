resource_group_name = "rg-test"
server_name                         = "jstartall09132021azsqlb"
database_names                      = ["azuresqldb08102021b"]
administrator_login_name            = "dbadmin"
sku_name                            = "S0"
azuresql_version                    = "12.0"
assign_identity                     = true
max_size_gb                         = 2
elastic_pool_id                     = null
create_mode                         = null
creation_source_database_id         = null
restore_point_in_time               = null
private_endpoint_connection_enabled = true
enable_failover_server              = false
failover_location                   = null
key_vault_name                      = "kv-postgresql16"
auditing_storage_account_name       = null

allowed_networks = [{
  subnet_id                 = "/subscriptions/8c5a7b36-81fd-4f19-a1f4-9cdb2a790f8e/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vm-test-vnet/subnets/vkdemo-snet"
}]

firewall_rules = {
  rule1 = {
    name             = "azuresql-firewall-rule-default"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

azuresql_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
}
