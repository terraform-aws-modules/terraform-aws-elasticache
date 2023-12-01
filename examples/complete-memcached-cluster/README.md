# Complete ElastiCache example for Memcached cluster

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
| <a name="module_memcached_cluster"></a> [memcached\_cluster](#module\_memcached\_cluster) | ../../ | n/a |

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
| <a name="output_address"></a> [address](#output\_address) | The DNS name of the cache cluster without the port appended |
| <a name="output_cache_nodes"></a> [cache\_nodes](#output\_cache\_nodes) | List of node objects including id, address, port and availability\_zone |
| <a name="output_configuration_endpoint"></a> [configuration\_endpoint](#output\_configuration\_endpoint) | The configuration endpoint to allow host discovery |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ElastiCache parameter group id |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | The ElastiCache parameter group name |
| <a name="output_subnet_group_ids"></a> [subnet\_group\_ids](#output\_subnet\_group\_ids) | The ElastiCache subnet group IDs |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The ElastiCache subnet group name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
