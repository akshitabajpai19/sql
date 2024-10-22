role_definitions = {
  role_network_peer = {
    name        = "TestNetworkRole"
    description = "Role Description"
    scope       = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXX"
    actions = [
      "Microsoft.Network/virtualNetworks/read"
    ]
    not_actions       = []
    data_actions      = []
    not_data_actions  = []
    assignable_scopes = ["/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXXXX"]
  }
  role_monitor_peer = {
    name        = "TestMonitorRole"
    description = "Role Description"
    scope       = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    actions = [
      "Microsoft.Network/virtualNetworks/read"
    ]
    not_actions       = []
    data_actions      = []
    not_data_actions  = []
    assignable_scopes = ["/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXX"]
  }
}
