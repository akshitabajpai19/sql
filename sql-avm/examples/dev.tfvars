key_vault_name      = "kv-postgresql22"
key_vault_rg_name   = "post-rg"
server_version      = "12.0"
location            = "Central US"
resource_group_name = "post-rg"
administrator_login = "sqladmin"
storage_account_name = "newstorageaccount1916"
storage_account_rg = "post-rg"
databases = {
  db01 = {
    name     = "new-db"
    sku_name = "Basic"
  }
}
name = "akshita-sql-test"
private_endpoints = {
  "pe01" = {
    subnet_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/post-rg/providers/Microsoft.Network/virtualNetworks/vm-test-vnet/subnets/new"

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

