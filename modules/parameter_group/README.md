# aws_elasticache_parameter_group

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_mode_enabled"></a> [cluster\_mode\_enabled](#input\_cluster\_mode\_enabled) | If cluster mode is enabled, add in `cluster-enabled` parameter, otherwise omit | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether the ElastiCache parameter group will be created or not | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the ElastiCache parameter group | `string` | `null` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the ElastiCache parameter group | `string` | `null` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier of the resource | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the ElastiCache parameter group | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | List of ElastiCache parameters to apply | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ElastiCache parameter group id |
| <a name="output_name"></a> [name](#output\_name) | The ElastiCache parameter group name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
