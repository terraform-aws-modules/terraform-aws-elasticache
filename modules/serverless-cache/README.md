# AWS ElastiCache - Serverless Cache Terraform module

Terraform module which creates AWS ElastiCache serverless cache resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples) directory for working examples to reference:

```hcl
module "elasticache_serverless_cache" {
  source = "terraform-aws-modules/elasticache/aws//modules/serverless-cache"

  engine     = "redis"
  cache_name = "example-serverless-cache"

  cache_usage_limits = {
    data_storage = {
      maximum = 2
    }
    ecpu_per_second = {
      maximum = 1000
    }
  }

  daily_snapshot_time  = "22:00"
  description          = "example-serverless-cache serverless cluster"
  kms_key_id           = aws_kms_key.this.arn
  major_engine_version = "7"

  security_group_ids = [module.sg.security_group_id]

  snapshot_retention_limit = 7
  subnet_ids               = module.vpc.private_subnets

  user_group_id = module.cache_user_group.group_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Memcached Cluster](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/memcached-cluster)
- [Redis Cluster](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-cluster)
- [Redis Clustered Mode](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-clustered-mode)
- [Redis Global Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-global-replication-group)
- [Redis Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-replication-group)
- [Serverless Cache](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/serverless-cache)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_serverless_cache.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_serverless_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cache_name"></a> [cache\_name](#input\_cache\_name) | The name which serves as a unique identifier to the serverless cache. | `string` | `null` | no |
| <a name="input_cache_usage_limits"></a> [cache\_usage\_limits](#input\_cache\_usage\_limits) | Sets the cache usage limits for storage and ElastiCache Processing Units for the cache. | `map(any)` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether serverless resource will be created. | `bool` | `true` | no |
| <a name="input_daily_snapshot_time"></a> [daily\_snapshot\_time](#input\_daily\_snapshot\_time) | The daily time that snapshots will be created from the new serverless cache. Only supported for engine type `redis`. Defaults to 0. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | User-created description for the serverless cache. | `string` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Name of the cache engine to be used for this cache cluster. Valid values are `memcached` or `redis`. | `string` | `"redis"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN of the customer managed key for encrypting the data at rest. If no KMS key is provided, a default service key is used. | `string` | `null` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | The version of the cache engine that will be used to create the serverless cache. | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | One or more VPC security groups associated with the serverless cache. | `list(string)` | `[]` | no |
| <a name="input_snapshot_arns_to_restore"></a> [snapshot\_arns\_to\_restore](#input\_snapshot\_arns\_to\_restore) | The list of ARN(s) of the snapshot that the new serverless cache will be created from. Available for Redis only. | `list(string)` | `null` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | (Redis only) The number of snapshots that will be retained for the serverless cache that is being created. | `number` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of the identifiers of the subnets where the VPC endpoint for the serverless cache will be deployed. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting serverless resources. | `map(string)` | `{}` | no |
| <a name="input_user_group_id"></a> [user\_group\_id](#input\_user\_group\_id) | The identifier of the UserGroup to be associated with the serverless cache. Available for Redis only. Default is NULL. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_serverless_cache_arn"></a> [serverless\_cache\_arn](#output\_serverless\_cache\_arn) | The amazon resource name of the serverless cache |
| <a name="output_serverless_cache_create_time"></a> [serverless\_cache\_create\_time](#output\_serverless\_cache\_create\_time) | Timestamp of when the serverless cache was created |
| <a name="output_serverless_cache_endpoint"></a> [serverless\_cache\_endpoint](#output\_serverless\_cache\_endpoint) | Represents the information required for client programs to connect to a cache node |
| <a name="output_serverless_cache_full_engine_version"></a> [serverless\_cache\_full\_engine\_version](#output\_serverless\_cache\_full\_engine\_version) | The name and version number of the engine the serverless cache is compatible with |
| <a name="output_serverless_cache_major_engine_version"></a> [serverless\_cache\_major\_engine\_version](#output\_serverless\_cache\_major\_engine\_version) | The version number of the engine the serverless cache is compatible with |
| <a name="output_serverless_cache_reader_endpoint"></a> [serverless\_cache\_reader\_endpoint](#output\_serverless\_cache\_reader\_endpoint) | Represents the information required for client programs to connect to a cache node |
| <a name="output_serverless_cache_status"></a> [serverless\_cache\_status](#output\_serverless\_cache\_status) | The current status of the serverless cache. The allowed values are CREATING, AVAILABLE, DELETING, CREATE-FAILED and MODIFYING |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-elasticache/blob/master/LICENSE).
