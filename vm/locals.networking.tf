locals {


  # Network Interface


  default_interface = tomap({
    private_interface = {
      name = "nic-${local.naming}"
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "internal"
          private_ip_subnet_resource_id = data.azurerm_subnet.subnet.id
          private_ip_address_allocation = "Dynamic"
          is_primary_ipconfiguration    = local.default_public_interface != null ? false : true
          create_public_ip_address      = false
        }
      }
      accelerated_networking_enabled = var.accelerated_networking
      inherit_tags                   = true
      tags                           = local.tags
      network_security_groups = {
        default_nsg = {
          network_security_group_resource_id = var.nic_nsg != "" ? data.azurerm_network_security_group.nsg[0].id : module.avm-res-network-nsg[0].resource_id
        }
      }
      role_assignments = merge({
        for group in data.azuread_group.vmcontributor :
        (group.display_name) => {
          description                         = "Default Virtual Machine Contributor Role Assignment for ${group.display_name}"
          principal_id                        = group.id
          role_definition_id_or_name          = "Virtual Machine Contributor"
          assign_to_child_public_ip_addresses = true
        }
        },
        {
          for spn in data.azuread_service_principal.ad_default_spn :
          (spn.display_name) => {
            description                         = "Default Virtual Machine Contributor Role Assignment for ${spn.display_name}"
            principal_id                        = spn.id
            role_definition_id_or_name          = "Virtual Machine Contributor"
            assign_to_child_public_ip_addresses = true
          }
      })
    }
  })

  default_public_interface = var.public_ip_enabled ? tomap({
    public_interface = {
      name = "nic-public-${local.naming}"
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "internal"
          private_ip_subnet_resource_id = data.azurerm_subnet.subnet_public[0].id
          private_ip_address_allocation = "Dynamic"
          is_primary_ipconfiguration    = true
          create_public_ip_address      = true
        }
      }
      accelerated_networking_enabled = var.accelerated_networking
      inherit_tags                   = true
      tags                           = local.tags
      network_security_groups = {
        default_nsg = {
          network_security_group_resource_id = var.public_nsg != "" ? data.azurerm_network_security_group.nsg_public[0].id : module.avm-res-network-nsg[0].resource_id
        }
      }
      role_assignments = merge({
        for group in data.azuread_group.vmcontributor :
        (group.display_name) => {
          description                         = "Default Virtual Machine Contributor Role Assignment for ${group.display_name}"
          principal_id                        = group.id
          role_definition_id_or_name          = "Virtual Machine Contributor"
          assign_to_child_public_ip_addresses = true
        }
        },
        {
          for spn in data.azuread_service_principal.ad_default_spn :
          (spn.display_name) => {
            description                         = "Default Virtual Machine Contributor Role Assignment for ${spn.display_name}"
            principal_id                        = spn.id
            role_definition_id_or_name          = "Virtual Machine Contributor"
            assign_to_child_public_ip_addresses = true
          }
      })
    }
  }) : tomap({})


  network_interfaces = merge(var.network_interfaces, local.default_interface, local.default_public_interface)


  # network according to https://mysupportdesk.service-now.com/esc?id=kb_article&table=kb_knowledge&sys_kb_id=ad5b2bc0c3a04a109054166ce0013184&searchTerm=155.70.

  denver_internet_nat     = ["155.70.39.45", "155.70.39.101", "155.70.39.135", "155.70.39.195", "199.168.32.200"]
  omaha_internet_nat      = ["155.70.23.45", "155.70.23.101", "155.70.59.135", "155.70.59.195"]
  winterpar_nnet_internet = ["64.45.200.0/24"]

  marin_nat_hides = [
    "168.251.2.32",
    "168.251.2.33",
    "168.251.2.34",
    "168.251.2.35",
    "168.251.2.36",
    "168.251.2.37",
    "168.251.2.38",
    "168.251.2.39",
    "168.251.2.40",
    "168.251.2.41",
    "168.251.2.42",
    "168.251.2.43",
    "168.251.2.44",
    "168.251.2.45",
    "168.251.2.46",
    "168.251.2.47",
  ]

  idc_internet_nat_hides = ["209.244.4.106"]

  adc_internet_nat_hides = ["209.244.4.189"]

  tulsa_internet_nat_hides = ["64.200.163.164"]

  london_internet_nat_hides = [
    "212.113.2.161",
    "195.166.116.237",
  ]

  hong_kong_internet_nat_hides = ["208.48.199.110"]

  idc2_internet_nat_hides = ["4.68.55.4"]

  idc2_global_protect_internet_nat_hides = [
    "155.70.104.245",
    "155.70.104.246",
    "155.70.104.247",
    "155.70.104.248",
    "155.70.104.249",
    "155.70.104.250",
    "155.70.104.251",
    "155.70.104.252",
    "155.70.104.253",
    "155.70.104.254",
  ]

  apac_global_protect_and_internet_gateway_internet_nat_hides = [
    "148.156.116.1",
    "148.156.116.2",
    "148.156.116.3",
    "148.156.116.4",
    "148.156.116.5",
    "148.156.116.6",
    "148.156.116.7",
  ]

  emea_lon_global_protect_internet_nat_hides = [
    "4.33.206.1",
    "4.33.206.2",
    "4.33.206.3",
    "4.33.206.4",
    "4.33.206.5",
    "4.33.206.6",
    "4.33.206.7",
  ]

  emea_bas_global_protect_internet_nat_hides = [
    "4.33.218.1",
    "4.33.218.2",
    "4.33.218.3",
    "4.33.218.4",
    "4.33.218.5",
    "4.33.218.6",
    "4.33.218.7",
  ]

  denver_global_protect_internet_nat_hides = [
    "155.70.42.238",
    "155.70.42.239",
    "155.70.42.240",
    "155.70.42.241",
    "155.70.42.242",
    "155.70.42.243",
  ]

  gateway_01_denver_global_protect_internet_nat_hides = [
    "155.70.104.122",
    "155.70.104.123",
    "155.70.104.124",
    "155.70.104.125",
    "155.70.104.126",
    "155.70.104.127",
  ]

  gateway_02_denver_global_protect_internet_nat_hides = [
    "155.70.104.117",
    "155.70.104.118",
    "155.70.104.119",
    "155.70.104.120",
    "155.70.104.121",
  ]

  omaha_global_protect_internet_nat_hides = [
    "155.70.21.228",
    "155.70.21.229",
    "155.70.21.230",
    "155.70.21.231",
    "155.70.21.232",
    "155.70.21.233",
  ]

  gateway_01_omaha_global_protect_internet_nat_hides = [
    "155.70.52.170",
    "155.70.52.171",
    "155.70.52.172",
    "155.70.52.173",
    "155.70.52.174",
    "155.70.52.175",
  ]

  gateway_02_omaha_global_protect_internet_nat_hides = [
    "155.70.52.165",
    "155.70.52.166",
    "155.70.52.167",
    "155.70.52.168",
    "155.70.52.169",
  ]

  marion_internet_gateway_and_global_protect_nat_hides = [
    "168.251.47.5",
    "168.251.47.6",
    "168.251.47.7",
    "168.251.47.8",
    "168.251.47.9",
    "168.251.47.10",
    "168.251.47.11",
    "168.251.47.12",
    "168.251.47.13",
    "168.251.47.14",
    "168.251.47.15",
  ]

  atlanta_global_protect_nat_hides = [
    "4.68.43.225",
    "4.68.43.226",
    "4.68.43.227",
    "4.68.43.228",
    "4.68.43.229",
    "4.68.43.230",
  ]

  all_nat_hides = concat(local.denver_internet_nat, local.omaha_internet_nat, local.winterpar_nnet_internet, local.marin_nat_hides, local.idc_internet_nat_hides, local.adc_internet_nat_hides, local.tulsa_internet_nat_hides, local.london_internet_nat_hides, local.hong_kong_internet_nat_hides, local.idc2_internet_nat_hides, local.idc2_global_protect_internet_nat_hides, local.apac_global_protect_and_internet_gateway_internet_nat_hides, local.emea_lon_global_protect_internet_nat_hides, local.emea_bas_global_protect_internet_nat_hides, local.denver_global_protect_internet_nat_hides, local.gateway_01_denver_global_protect_internet_nat_hides, local.gateway_02_denver_global_protect_internet_nat_hides, local.omaha_global_protect_internet_nat_hides, local.gateway_01_omaha_global_protect_internet_nat_hides, local.gateway_02_omaha_global_protect_internet_nat_hides, local.marion_internet_gateway_and_global_protect_nat_hides, local.atlanta_global_protect_nat_hides)

  ## AVM NSG 

  nsg_role_assigments = { for g in data.azuread_group.default_contrib_group : lower(g.display_name) => {
    role_definition_id_or_name = "Network Contributor"
    principal_id               = g.id
    principal_type             = "Group"
    desscription               = "Network Contributor for NSG"
  } }

  default_security_rules = {
    ssh_priv = {
      name                       = "ssh_priv"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.machine_ssh_port
      source_address_prefixes    = local.all_nat_hides
      destination_address_prefix = "*"
    }
  }

  security_rules = merge(local.default_security_rules, var.additional_security_rules)
}
