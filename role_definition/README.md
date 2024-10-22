<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |
| <a name="requirement_validation"></a> [validation](#requirement\_validation) | ~> 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified.  | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | (Required) The scope at which the Role Assignment applies to.  | `string` | `null` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_definition_ids_map"></a> [role\_definition\_ids\_map](#output\_role\_definition\_ids\_map) | The Map of the Role Definition IDs. |
<!-- END_TF_DOCS -->
