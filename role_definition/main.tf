resource "azurerm_role_definition" "this" {
  for_each    = var.role_definitions
  name        = each.value["name"]
  description = each.value["description"]
  scope       = each.value["scope"]

  permissions {
    actions          = each.value["actions"]
    not_actions      = each.value["not_actions"]
    data_actions     = each.value["data_actions"]
    not_data_actions = each.value["not_data_actions"]
  }

  assignable_scopes = each.value["assignable_scopes"]
}
