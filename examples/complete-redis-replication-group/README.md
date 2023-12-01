# Complete ElastiCache example for Redis cluster

Configuration in this directory creates set of ElastiCaChe resources including cluster, subnet group and parameter group.

Data sources are used to discover existing VPC resources (VPC, subnet and security group).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redis_repl_group"></a> [redis\_repl\_group](#module\_redis\_repl\_group) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_address"></a> [endpoint\_address](#output\_endpoint\_address) | The address of the replication group configuration endpoint when cluster mode is enabled |
| <a name="output_id"></a> [id](#output\_id) | The ID of the ElastiCache Replication Group |
| <a name="output_member_clusters"></a> [member\_clusters](#output\_member\_clusters) | The identifiers of all the nodes that are part of this replication group. |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ElastiCache parameter group id |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | The ElastiCache parameter group name |
| <a name="output_primary_endpoint_address"></a> [primary\_endpoint\_address](#output\_primary\_endpoint\_address) | The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled |
| <a name="output_subnet_group_ids"></a> [subnet\_group\_ids](#output\_subnet\_group\_ids) | The ElastiCache subnet group IDs |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The ElastiCache subnet group name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
