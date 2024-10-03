# local
appname             = "example-app"
env                 = "dev"
appid               = "app123"
resourcetype        = "service"
costAppOwnerManager = "manager@example.com"
costAppOwnerTech    = "tech@example.com"
costBudgetOwner     = "budgetowner@example.com"
costCostCenter      = "cost-center"
location          = "your-location"
costbaseline        = "2024"

# Required Inputs
domain_name             = "example004.com"
resource_group_name     = "your-rg"

# Optional Inputs
a_records = {
  record1 = {
    name                = "record1"
    resource_group_name = "your-rg"
    zone_name           = "example004.com"
    ttl                 = 3600
    records             = ["10.0.0.1"]
    tags                = {
      environment = "production"
    }
  }
}

aaaa_records = {}

cname_records = {
  record1 = {
    name                = "cname1"
    resource_group_name = "your-rg"
    zone_name           = "example004.com"
    ttl                 = 3600
    record              = "cname.example004.com"
    tags                = {
      environment = "production"
    }
  }
}

enable_telemetry = true

mx_records = {
  mx1 = {
    name                = "@"
    resource_group_name = "new-epac"
    zone_name           = "example004.com"
    ttl                 = 3600
    records             = {
      mail1 = {
        preference = 10
        exchange   = "mail.example004.com"
      }
    }
    tags                = {
      environment = "production"
    }
  }
}

ptr_records = {}

soa_record = {
  email        = "admin.corp.com"
  expire_time  = 604800
  minimum_ttl  = 300
  refresh_time = 3600
  retry_time   = 300
  ttl          = 3600
  tags         = {
    environment = "production"
  }
}

srv_records = {}

tags = {
  environment = "production"
  owner       = "A"
}

txt_records = {}

virtual_network_links = {
  vnetlink1 = {
    vnetlinkname     = "vnet-link-12"
    vnetid           = "/subscriptions/your-sub/resourceGroups/your-rg/providers/Microsoft.Network/virtualNetworks/your-vnet"
    autoregistration = true
    tags             = {
      environment = "production"
    }
  }
}
