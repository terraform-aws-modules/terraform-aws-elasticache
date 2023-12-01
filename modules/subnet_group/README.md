# aws_elasticache_subnet_group

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
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Determines whether the Elasticache subnet group will be created or not | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the Elasticache subnet group | `string` | `null` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier of the resource | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Elasticache subnet group. Elasticache converts this name to lowercase | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC Subnet IDs for the Elasticache subnet group | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | The ElastiCache subnet group IDs |
| <a name="output_name"></a> [name](#output\_name) | The ElastiCache subnet group name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
