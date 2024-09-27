sql_servers = {
  test-post = {
    name                          = "test-post"
    resource_group_name           = "post-rg"
    location                      = "Central India"
    administrator_login_name      = "newuser"
    version                       = "12.0"
    public_network_access_enabled = true
    minimum_tls_version           = "1.2"
    tags = {
      environment = "production"
      department  = "IT"
    }
  }
}
location            = "Central India"
appid               = "00000000-0000-0000-0000-000000000000"
appname             = "new-app"
env                 = "dev"
costCostCenter      = "123"
costVP              = "356"
costAppOwnerTech    = "new"
costAppOwnerManager = "manager"
costBudgetOwner     = "owner"
costbaseline        = "baseline"
resourcetype        = "resource"
costDivision        = "1363"
costAllocation      = "1234"
appFunction         = "function"
monthlyBudget       = "123456"
