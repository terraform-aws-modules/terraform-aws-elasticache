# aws_elasticache_parameter_group

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.23 |

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

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
