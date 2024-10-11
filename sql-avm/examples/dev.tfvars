key_vault_name      = "kv-postgresql22"
key_vault_rg_name   = "post-rg"
server_version      = "12.0"
location            = "Central US"
resource_group_name = "post-rg"
administrator_login = "sqladmin"
databases = {
  db01 = {
    name     = "new-db"
    sku_name = "Basic"
  }
}
name = "new-sql-db"
private_endpoints = {
  "pe01" = {
    subnet_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/post-rg/providers/Microsoft.Network/virtualNetworks/vm-test-vnet/subnets/test"

  }
}

appid               = "t0000000"
appname             = "newapp"
env                 = "dev"
costAppOwnerTech    = "new"
costAppOwnerManager = "manager"
costBudgetOwner     = "owner"
costbaseline        = "baseline"
resourcetype        = "resource"
costDivision        = "t363"
costAllocation      = "t234"
appFunction         = "function"
monthlyBudget       = "yh23456"
costCostCenter      = "hjbd"
costVP              = "sjdhcj"

