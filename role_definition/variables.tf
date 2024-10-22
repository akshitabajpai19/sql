variable "role_definitions" {
  description = "Map of roles definitions."
  type = map(object({
    name              = string                       # (Required) The name of the Role Definition
    description       = string                       # (Optional) A description of the Role Definition
    scope             = string                       # (Required) The scope at which the Role Definition applies
    actions           = optional(list(string), null) # (Optional) One or more Allowed Actions
    not_actions       = optional(list(string), null) # (Optional) One or more Disallowed Actions
    data_actions      = optional(list(string), null) # (Optional) One or more Allowed Data Actions
    not_data_actions  = optional(list(string), null) # (Optional) One or more Disallowed Data Actions
    assignable_scopes = optional(list(string), null) # (Optional) One or more assignable scopes for this Role Definition
  }))
  default = {}
}
