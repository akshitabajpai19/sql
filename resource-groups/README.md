<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_validation"></a> [validation](#requirement\_validation) | 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_validation"></a> [validation](#provider\_validation) | 1.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm-res-resources-resourcegroup"></a> [avm-res-resources-resourcegroup](#module\_avm-res-resources-resourcegroup) | Azure/avm-res-resources-resourcegroup/azurerm | 0.1.0 |

## Resources

| Name | Type |
|------|------|
| [validation_warning.managed_by](https://registry.terraform.io/providers/tlkamp/validation/1.1.1/docs/resources/warning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additionalcontext"></a> [additionalcontext](#input\_additionalcontext) | used for naming purposes such as 01 or 02 | `string` | n/a | yes |
| <a name="input_appFunction"></a> [appFunction](#input\_appFunction) | app function | `string` | n/a | yes |
| <a name="input_appid"></a> [appid](#input\_appid) | The related application for resources. Used for tagging and naming purposes. | `string` | n/a | yes |
| <a name="input_appname"></a> [appname](#input\_appname) | the app name for the resources.  Used for tagging and naming purposes | `string` | n/a | yes |
| <a name="input_costAllocation"></a> [costAllocation](#input\_costAllocation) | can only be sharedcosts or chargeback | `string` | n/a | yes |
| <a name="input_costAppOwnerManager"></a> [costAppOwnerManager](#input\_costAppOwnerManager) | The app owner manager responsible for resources. Used for tagging purposes. | `string` | n/a | yes |
| <a name="input_costAppOwnerTech"></a> [costAppOwnerTech](#input\_costAppOwnerTech) | The app owner responsible for resources. Used for tagging and naming purposes. | `string` | n/a | yes |
| <a name="input_costBudgetOwner"></a> [costBudgetOwner](#input\_costBudgetOwner) | The budget owner responsible for resources. Used for tagging purposes. | `string` | n/a | yes |
| <a name="input_costCostCenter"></a> [costCostCenter](#input\_costCostCenter) | The cost center code for resources. Used for tagging and naming purposes. | `string` | n/a | yes |
| <a name="input_costDivision"></a> [costDivision](#input\_costDivision) | cost division | `string` | n/a | yes |
| <a name="input_costVP"></a> [costVP](#input\_costVP) | The cost vp for resources. Used for tagging purposes. | `string` | n/a | yes |
| <a name="input_costbaseline"></a> [costbaseline](#input\_costbaseline) | year resource created | `string` | n/a | yes |
| <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry) | This variable controls whether or not telemetry is enabled for the module.<br>For more information see <https://aka.ms/avm/telemetryinfo>.<br>If it is set to false, then no telemetry will be collected. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment code the for resources. Used for tagging and naming purposes. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Required. The Azure region for deployment of the this resource. | `string` | n/a | yes |
| <a name="input_lock"></a> [lock](#input\_lock) | Controls the Resource Lock configuration for this resource. The following properties can be specified:<br><br>  - `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.<br>  - `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource. | <pre>object({<br>    kind = string<br>    name = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | resource group is managed by | `string` | `null` | no |
| <a name="input_monthlyBudget"></a> [monthlyBudget](#input\_monthlyBudget) | monthly budget | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | If we don't give the name, it will be created by local naming convention | `string` | `null` | no |
| <a name="input_resourcetype"></a> [resourcetype](#input\_resourcetype) | resource type -- 3 letters | `string` | n/a | yes |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | Optional. A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `role_definition_id_or_name` - (Required) The ID or name of the role definition to assign to the principal.<br>- `principal_id` - (Required) The ID of the principal to assign the role to.<br>- `description` - (Optional) The description of the role assignment.<br>- `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.<br>- `condition` - (Optional) The condition which will be used to scope the role assignment.<br>- `condition_version` - (Optional) The version of the condition syntax. Valid values are '2.0'.<br>- `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. NOTE:<br>this field is only used in cross tenant scenario.<br><br>> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.<br><br>Example Input:<pre>hcl<br>role_assignments = {<br>  "role_assignment1" = {<br>    role_definition_id_or_name = "Reader"<br>    principal_id = "4179302c-702e-4de7-a061-beacd0a1be09"<br>    <br>  },<br>"role_assignment2" = {<br>  role_definition_id_or_name = "2a2b9908-6ea1-4ae2-8e65-a410df84e7d1" // Storage Blob Data Reader Role Guid <br>  principal_id = "4179302c-702e-4de7-a061-beacd0a1be09"<br>  skip_service_principal_aad_check = false<br>  condition_version = "2.0"<br>  condition = <<-EOT<br>(<br>  (<br>    !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})<br>  )<br>OR <br>  (<br>  @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId]<br>  ForAnyOfAnyValues:GuidEquals {4179302c-702e-4de7-a061-beacd0a1be09}<br>  )<br>)<br>AND<br>(<br>  (<br>    !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})<br>  )<br>  OR <br>  (<br>    @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId]<br>    ForAnyOfAnyValues:GuidEquals {dc887ae1-fe50-4307-be53-213ff08f3c0b}<br>  )<br>)<br>EOT  <br>  }<br>}</pre> | <pre>map(object({<br>    role_definition_id_or_name             = string<br>    principal_id                           = string<br>    description                            = optional(string, null)<br>    skip_service_principal_aad_check       = optional(bool, false)<br>    condition                              = optional(string, null)<br>    condition_version                      = optional(string, null)<br>    delegated_managed_identity_resource_id = optional(string, null)<br>    principal_type                         = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags of the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The name of the resource group |
| <a name="output_resource"></a> [resource](#output\_resource) | This is the full output for the resource group. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The resource Id of the resource group |
<!-- END_TF_DOCS -->