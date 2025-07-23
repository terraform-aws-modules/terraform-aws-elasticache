# AWS ElastiCache Terraform module

Terraform module which creates AWS ElastiCache resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples) directory for working examples to reference:

### Memcached Cluster

```hcl
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id               = "example-memcached"
  create_cluster           = true
  create_replication_group = false

  engine          = "memcached"
  engine_version  = "1.6.17"
  node_type       = "cache.t4g.small"
  num_cache_nodes = 2
  az_mode         = "cross-az"

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "memcached1.6"
  parameters = [
    {
      name  = "idle_timeout"
      value = 60
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Redis Cluster

```hcl
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id               = "example-redis"
  create_cluster           = true
  create_replication_group = false

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "redis7"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Redis Cluster Mode

```hcl
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  replication_group_id = "example-redis-cluster"

  # Cluster mode
  cluster_mode_enabled       = true
  num_node_groups            = 2
  replicas_per_node_group    = 3
  automatic_failover_enabled = true
  multi_az_enabled           = true

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "redis7"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Redis Global Replication Group

```hcl
module "elasticache_primary" {
  source = "terraform-aws-modules/elasticache/aws"

  replication_group_id                    = "example-redis-global-replication-group"
  create_primary_global_replication_group = true

  engine_version = "7.1"
  node_type      = "cache.r7g.large"

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "redis7"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "elasticache_secondary" {
  source = "terraform-aws-modules/elasticache/aws"

  providers = {
    aws = aws.other_region
  }

  replication_group_id        = "example-redis-global-replication-group"
  global_replication_group_id = module.elasticache_primary.global_replication_group_id

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc.private_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Redis Replication Group

```hcl
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  replication_group_id = "example-redis-replication-group"

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

  transit_encryption_enabled = true
  auth_token                 = "PickSomethingMoreSecure123!"
  maintenance_window         = "sun:05:00-sun:09:00"
  apply_immediately          = true

  # Security group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "redis7"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Serverless Cache

```hcl
module "elasticache" {
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
  security_group_ids   = [module.sg.security_group_id]

  snapshot_retention_limit = 7
  subnet_ids               = module.vpc.private_subnets

  user_group_id = module.cache_user_group.group_id
}
```

### Valkey Replication Group

```hcl
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  replication_group_id = local.name

  engine         = "valkey"
  engine_version = "7.2"
  node_type      = "cache.t4g.small"

  transit_encryption_enabled = true
  auth_token                 = "PickSomethingMoreSecure123!"
  maintenance_window         = "sun:05:00-sun:09:00"
  apply_immediately          = true

  # Security Group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_group_name        = local.name
  subnet_group_description = "Valkey replication group subnet group"
  subnet_ids               = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group      = true
  parameter_group_name        = local.name
  parameter_group_family      = "valkey7"
  parameter_group_description = "Valkey replication group parameter group"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = local.tags
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Memcached Cluster](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/memcached-cluster)
- [Redis Cluster](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-cluster)
- [Redis Cluster Mode](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-cluster-mode)
- [Redis Global Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-global-replication-group)
- [Redis Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-replication-group)
- [Serverless Cache](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/serverless-cache)
- [Valkey Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/valkey-replication-group)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.93 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.93 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_global_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_global_replication_group) | resource |
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Whether any database modifications are applied immediately, or during the next maintenance window. Default is `false` | `bool` | `null` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Whether to enable encryption at rest | `bool` | `true` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | The password used to access a password protected server. Can be specified only if `transit_encryption_enabled = true` | `string` | `null` | no |
| <a name="input_auth_token_update_strategy"></a> [auth\_token\_update\_strategy](#input\_auth\_token\_update\_strategy) | Strategy to use when updating the `auth_token`. Valid values are `SET`, `ROTATE`, and `DELETE`. Defaults to `ROTATE` | `string` | `null` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type `redis` and `valkey` and if the engine version is 6 or higher. Defaults to `true` | `bool` | `null` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups | `bool` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use `preferred_availability_zones` instead | `string` | `null` | no |
| <a name="input_az_mode"></a> [az\_mode](#input\_az\_mode) | Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are `single-az` or `cross-az`, default is `single-az` | `string` | `null` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource | `string` | `""` | no |
| <a name="input_cluster_mode"></a> [cluster\_mode](#input\_cluster\_mode) | Specifies whether cluster mode is enabled or disabled. Valid values are enabled or disabled or compatible | `string` | `null` | no |
| <a name="input_cluster_mode_enabled"></a> [cluster\_mode\_enabled](#input\_cluster\_mode\_enabled) | Whether to enable Redis [cluster mode https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Replication.Redis-RedisCluster.html] | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Determines whether an ElastiCache cluster will be created or not | `bool` | `false` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Determines whether the ElastiCache parameter group will be created or not | `bool` | `false` | no |
| <a name="input_create_primary_global_replication_group"></a> [create\_primary\_global\_replication\_group](#input\_create\_primary\_global\_replication\_group) | Determines whether an primary ElastiCache global replication group will be created | `bool` | `false` | no |
| <a name="input_create_replication_group"></a> [create\_replication\_group](#input\_create\_replication\_group) | Determines whether an ElastiCache replication group will be created or not | `bool` | `true` | no |
| <a name="input_create_secondary_global_replication_group"></a> [create\_secondary\_global\_replication\_group](#input\_create\_secondary\_global\_replication\_group) | Determines whether an secondary ElastiCache global replication group will be created | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_create_subnet_group"></a> [create\_subnet\_group](#input\_create\_subnet\_group) | Determines whether the Elasticache subnet group will be created or not | `bool` | `true` | no |
| <a name="input_data_tiering_enabled"></a> [data\_tiering\_enabled](#input\_data\_tiering\_enabled) | Enables data tiering. Data tiering is only supported for replication groups using the `r6gd` node type. This parameter must be set to true when using `r6gd` nodes | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | User-created description for the replication group | `string` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Name of the cache engine to be used for this cache cluster. Valid values are `memcached`, `redis`, or `valkey` | `string` | `"redis"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version number of the cache engine to be used. If not set, defaults to the latest version | `string` | `null` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | (Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made | `string` | `null` | no |
| <a name="input_global_replication_group_id"></a> [global\_replication\_group\_id](#input\_global\_replication\_group\_id) | The ID of the global replication group to which this replication group should belong | `string` | `null` | no |
| <a name="input_global_replication_group_id_suffix"></a> [global\_replication\_group\_id\_suffix](#input\_global\_replication\_group\_id\_suffix) | The ID suffix of the global replication group | `string` | `null` | no |
| <a name="input_ip_discovery"></a> [ip\_discovery](#input\_ip\_discovery) | The IP version to advertise in the discovery protocol. Valid values are `ipv4` or `ipv6` | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if `at_rest_encryption_enabled = true` | `string` | `null` | no |
| <a name="input_log_delivery_configuration"></a> [log\_delivery\_configuration](#input\_log\_delivery\_configuration) | (Redis OSS or Valkey) Specifies the destination and format of Redis OSS/Valkey SLOWLOG or Redis OSS/Valkey Engine Log | `any` | <pre>{<br/>  "slow-log": {<br/>    "destination_type": "cloudwatch-logs",<br/>    "log_format": "json"<br/>  }<br/>}</pre> | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is `ddd:hh24:mi-ddd:hh24:mi` (24H Clock UTC) | `string` | `null` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Specifies whether to enable Multi-AZ Support for the replication group. If true, `automatic_failover_enabled` must also be enabled. Defaults to `false` | `bool` | `false` | no |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | The IP versions for cache cluster connections. Valid values are `ipv4`, `ipv6` or `dual_stack` | `string` | `null` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The instance class used. For Memcached, changing this value will re-create the resource | `string` | `null` | no |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | ARN of an SNS topic to send ElastiCache notifications to | `string` | `null` | no |
| <a name="input_num_cache_clusters"></a> [num\_cache\_clusters](#input\_num\_cache\_clusters) | Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with `num_node_groups`. Defaults to `1` | `number` | `null` | no |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40. If this number is reduced on subsequent runs, the highest numbered nodes will be removed | `number` | `1` | no |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | Number of node groups (shards) for this Redis replication group. Changing this number will trigger a resizing operation before other settings modifications | `number` | `null` | no |
| <a name="input_outpost_mode"></a> [outpost\_mode](#input\_outpost\_mode) | Specify the outpost mode that will apply to the cache cluster creation. Valid values are `single-outpost` and `cross-outpost`, however AWS currently only supports `single-outpost` mode | `string` | `null` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | The description of the ElastiCache parameter group. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the ElastiCache parameter group | `string` | `""` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the parameter group. If `create_parameter_group` is `true`, this is the name assigned to the parameter group created. Otherwise, this is the name of an existing parameter group | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | List of ElastiCache parameters to apply | `list(map(string))` | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | The port number on which each of the cache nodes will accept connections. For Memcached the default is `11211`, and for Redis the default port is `6379` | `number` | `null` | no |
| <a name="input_preferred_availability_zones"></a> [preferred\_availability\_zones](#input\_preferred\_availability\_zones) | List of the Availability Zones in which cache nodes are created | `list(string)` | `[]` | no |
| <a name="input_preferred_cache_cluster_azs"></a> [preferred\_cache\_cluster\_azs](#input\_preferred\_cache\_cluster\_azs) | List of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is considered. The first item in the list will be the primary node. Ignored when updating | `list(string)` | `[]` | no |
| <a name="input_preferred_outpost_arn"></a> [preferred\_outpost\_arn](#input\_preferred\_outpost\_arn) | (Required if `outpost_mode` is specified) The outpost ARN in which the cache cluster will be created | `string` | `null` | no |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | Number of replica nodes in each node group. Changing this number will trigger a resizing operation before other settings modifications. Valid values are 0 to 5 | `number` | `null` | no |
| <a name="input_replication_group_id"></a> [replication\_group\_id](#input\_replication\_group\_id) | Replication group identifier. When `create_replication_group` is set to `true`, this is the ID assigned to the replication group created. When `create_replication_group` is set to `false`, this is the ID of an externally created replication group | `string` | `null` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | One or more VPC security groups associated with the cache cluster | `list(string)` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_names"></a> [security\_group\_names](#input\_security\_group\_names) | Names of one or more Amazon VPC security groups associated with this replication group | `list(string)` | `[]` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Security group ingress and egress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input\_snapshot\_arns) | (Redis only) Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3 | `list(string)` | `[]` | no |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input\_snapshot\_name) | (Redis only) Name of a snapshot from which to restore data into the new node group. Changing `snapshot_name` forces a new resource | `string` | `null` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | (Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them | `number` | `null` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | (Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. Example: `05:00-09:00` | `string` | `null` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | Description for the Elasticache subnet group | `string` | `null` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | The name of the subnet group. If `create_subnet_group` is `true`, this is the name assigned to the subnet group created. Otherwise, this is the name of an existing subnet group | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC Subnet IDs for the Elasticache subnet group | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting cluster resource | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Enable encryption in-transit. Supported only with Memcached versions `1.6.12` and later, running in a VPC | `bool` | `true` | no |
| <a name="input_transit_encryption_mode"></a> [transit\_encryption\_mode](#input\_transit\_encryption\_mode) | A setting that enables clients to migrate to in-transit encryption with no downtime. Valid values are preferred and required | `string` | `null` | no |
| <a name="input_user_group_ids"></a> [user\_group\_ids](#input\_user\_group\_ids) | User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid | `list(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Identifier of the VPC where the security group will be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#output\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_cluster_address"></a> [cluster\_address](#output\_cluster\_address) | (Memcached only) DNS name of the cache cluster without the port appended |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ARN of the ElastiCache Cluster |
| <a name="output_cluster_cache_nodes"></a> [cluster\_cache\_nodes](#output\_cluster\_cache\_nodes) | List of node objects including `id`, `address`, `port` and `availability_zone` |
| <a name="output_cluster_configuration_endpoint"></a> [cluster\_configuration\_endpoint](#output\_cluster\_configuration\_endpoint) | (Memcached only) Configuration endpoint to allow host discovery |
| <a name="output_cluster_engine_version_actual"></a> [cluster\_engine\_version\_actual](#output\_cluster\_engine\_version\_actual) | Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine |
| <a name="output_global_replication_group_arn"></a> [global\_replication\_group\_arn](#output\_global\_replication\_group\_arn) | ARN of the created ElastiCache Global Replication Group |
| <a name="output_global_replication_group_engine_version_actual"></a> [global\_replication\_group\_engine\_version\_actual](#output\_global\_replication\_group\_engine\_version\_actual) | The full version number of the cache engine running on the members of this global replication group |
| <a name="output_global_replication_group_id"></a> [global\_replication\_group\_id](#output\_global\_replication\_group\_id) | ID of the ElastiCache Global Replication Group |
| <a name="output_global_replication_group_node_groups"></a> [global\_replication\_group\_node\_groups](#output\_global\_replication\_group\_node\_groups) | Set of node groups (shards) on the global replication group |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | The AWS ARN associated with the parameter group |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ElastiCache parameter group name |
| <a name="output_replication_group_arn"></a> [replication\_group\_arn](#output\_replication\_group\_arn) | ARN of the created ElastiCache Replication Group |
| <a name="output_replication_group_configuration_endpoint_address"></a> [replication\_group\_configuration\_endpoint\_address](#output\_replication\_group\_configuration\_endpoint\_address) | Address of the replication group configuration endpoint when cluster mode is enabled |
| <a name="output_replication_group_engine_version_actual"></a> [replication\_group\_engine\_version\_actual](#output\_replication\_group\_engine\_version\_actual) | Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine |
| <a name="output_replication_group_id"></a> [replication\_group\_id](#output\_replication\_group\_id) | ID of the ElastiCache Replication Group |
| <a name="output_replication_group_member_clusters"></a> [replication\_group\_member\_clusters](#output\_replication\_group\_member\_clusters) | Identifiers of all the nodes that are part of this replication group |
| <a name="output_replication_group_primary_endpoint_address"></a> [replication\_group\_primary\_endpoint\_address](#output\_replication\_group\_primary\_endpoint\_address) | Address of the endpoint for the primary node in the replication group, if the cluster mode is disabled |
| <a name="output_replication_group_reader_endpoint_address"></a> [replication\_group\_reader\_endpoint\_address](#output\_replication\_group\_reader\_endpoint\_address) | Address of the endpoint for the reader node in the replication group, if the cluster mode is disabled |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The ElastiCache subnet group name |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-elasticache/blob/master/LICENSE).
