role_definitions = {
  role_network_peer = {
    name        = "TestNetworkRole"
    description = "Role Description"
    scope       = "/subscriptions/8c5a7b36-81fd-4f19-a1f4-9cdb2a790f8e"
    actions = [
      "Microsoft.Network/virtualNetworks/read"
    ]
    not_actions       = []
    data_actions      = []
    not_data_actions  = []
    assignable_scopes = ["/subscriptions/8c5a7b36-81fd-4f19-a1f4-9cdb2a790f8e"]
  }
  role_monitor_peer = {
    name        = "TestMonitorRole"
    description = "Role Description"
    scope       = "/subscriptions/8c5a7b36-81fd-4f19-a1f4-9cdb2a790f8e"
    actions = [
      "Microsoft.Network/virtualNetworks/read"
    ]
    not_actions       = []
    data_actions      = []
    not_data_actions  = []
    assignable_scopes = ["/subscriptions/8c5a7b36-81fd-4f19-a1f4-9cdb2a790f8e"]
  }
}
