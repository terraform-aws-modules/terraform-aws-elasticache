variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster
################################################################################

variable "create_cluster" {
  description = "Determines whether an ElastiCache cluster will be created or not"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Whether any database modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type `redis` and `valkey` and if the engine version is 6 or higher. Defaults to `true`"
  type        = bool
  default     = null
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups"
  type        = bool
  default     = null
}

variable "availability_zone" {
  description = "Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use `preferred_availability_zones` instead"
  type        = string
  default     = null
}

variable "az_mode" {
  description = "Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are `single-az` or `cross-az`, default is `single-az`"
  type        = string
  default     = null
}

variable "cluster_id" {
  description = "Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource"
  type        = string
  default     = ""
}

variable "engine" {
  description = "Name of the cache engine to be used for this cache cluster. Valid values are `memcached`, `redis`, or `valkey`"
  type        = string
  default     = "redis"
}

variable "engine_version" {
  description = "Version number of the cache engine to be used. If not set, defaults to the latest version"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "(Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made"
  type        = string
  default     = null
}

variable "ip_discovery" {
  description = "The IP version to advertise in the discovery protocol. Valid values are `ipv4` or `ipv6`"
  type        = string
  default     = null
}

variable "log_delivery_configuration" {
  description = "(Redis OSS or Valkey) Specifies the destination and format of Redis OSS/Valkey SLOWLOG or Redis OSS/Valkey Engine Log"
  type        = any
  default = {
    slow-log = {
      destination_type = "cloudwatch-logs"
      log_format       = "json"
    }
  }
}

variable "maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is `ddd:hh24:mi-ddd:hh24:mi` (24H Clock UTC)"
  type        = string
  default     = null
}

variable "network_type" {
  description = "The IP versions for cache cluster connections. Valid values are `ipv4`, `ipv6` or `dual_stack`"
  type        = string
  default     = null
}

variable "node_type" {
  description = "The instance class used. For Memcached, changing this value will re-create the resource"
  type        = string
  default     = null
}

variable "notification_topic_arn" {
  description = "ARN of an SNS topic to send ElastiCache notifications to"
  type        = string
  default     = null
}

variable "num_cache_nodes" {
  description = "The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40. If this number is reduced on subsequent runs, the highest numbered nodes will be removed"
  type        = number
  default     = 1
}

variable "outpost_mode" {
  description = "Specify the outpost mode that will apply to the cache cluster creation. Valid values are `single-outpost` and `cross-outpost`, however AWS currently only supports `single-outpost` mode"
  type        = string
  default     = null
}

variable "port" {
  description = "The port number on which each of the cache nodes will accept connections. For Memcached the default is `11211`, and for Redis the default port is `6379`"
  type        = number
  default     = null
}

variable "preferred_availability_zones" {
  description = "List of the Availability Zones in which cache nodes are created"
  type        = list(string)
  default     = []
}

variable "preferred_outpost_arn" {
  description = "(Required if `outpost_mode` is specified) The outpost ARN in which the cache cluster will be created"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the cache cluster"
  type        = list(string)
  default     = []
}

variable "snapshot_arns" {
  description = "(Redis only) Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3"
  type        = list(string)
  default     = []
}

variable "snapshot_name" {
  description = "(Redis only) Name of a snapshot from which to restore data into the new node group. Changing `snapshot_name` forces a new resource"
  type        = string
  default     = null
}

variable "snapshot_retention_limit" {
  description = "(Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type        = number
  default     = null
}

variable "snapshot_window" {
  description = "(Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. Example: `05:00-09:00`"
  type        = string
  default     = null
}

variable "transit_encryption_enabled" {
  description = "Enable encryption in-transit. Supported only with Memcached versions `1.6.12` and later, running in a VPC"
  type        = bool
  default     = true
}

variable "transit_encryption_mode" {
  description = "A setting that enables clients to migrate to in-transit encryption with no downtime. Valid values are preferred and required"
  type        = string
  default     = null
}

################################################################################
# Replication Group
################################################################################

variable "create_replication_group" {
  description = "Determines whether an ElastiCache replication group will be created or not"
  type        = bool
  default     = true
}

variable "auth_token" {
  description = "The password used to access a password protected server. Can be specified only if `transit_encryption_enabled = true`"
  type        = string
  default     = null
}

variable "auth_token_update_strategy" {
  description = "Strategy to use when updating the `auth_token`. Valid values are `SET`, `ROTATE`, and `DELETE`. Defaults to `ROTATE`"
  type        = string
  default     = null
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "data_tiering_enabled" {
  description = "Enables data tiering. Data tiering is only supported for replication groups using the `r6gd` node type. This parameter must be set to true when using `r6gd` nodes"
  type        = bool
  default     = null
}

variable "description" {
  description = "User-created description for the replication group"
  type        = string
  default     = null
}

variable "global_replication_group_id" {
  description = "The ID of the global replication group to which this replication group should belong"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if `at_rest_encryption_enabled = true`"
  type        = string
  default     = null
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ Support for the replication group. If true, `automatic_failover_enabled` must also be enabled. Defaults to `false`"
  type        = bool
  default     = false
}

variable "num_cache_clusters" {
  description = "Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with `num_node_groups`. Defaults to `1`"
  type        = number
  default     = null
}

variable "num_node_groups" {
  description = "Number of node groups (shards) for this Redis replication group. Changing this number will trigger a resizing operation before other settings modifications"
  type        = number
  default     = null
}

variable "preferred_cache_cluster_azs" {
  description = "List of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is considered. The first item in the list will be the primary node. Ignored when updating"
  type        = list(string)
  default     = []
}

variable "replicas_per_node_group" {
  description = "Number of replica nodes in each node group. Changing this number will trigger a resizing operation before other settings modifications. Valid values are 0 to 5"
  type        = number
  default     = null
}

variable "cluster_mode" {
  description = "Specifies whether cluster mode is enabled or disabled. Valid values are enabled or disabled or compatible"
  type        = string
  default     = null
}

variable "replication_group_id" {
  description = "Replication group identifier. When `create_replication_group` is set to `true`, this is the ID assigned to the replication group created. When `create_replication_group` is set to `false`, this is the ID of an externally created replication group"
  type        = string
  default     = null
}

variable "security_group_names" {
  description = "Names of one or more Amazon VPC security groups associated with this replication group"
  type        = list(string)
  default     = []
}

variable "user_group_ids" {
  description = "User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid"
  type        = list(string)
  default     = null
}

variable "cluster_mode_enabled" {
  description = "Whether to enable Redis [cluster mode https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Replication.Redis-RedisCluster.html]"
  type        = bool
  default     = false
}

################################################################################
# Global Replication Group
################################################################################

variable "create_primary_global_replication_group" {
  description = "Determines whether an primary ElastiCache global replication group will be created"
  type        = bool
  default     = false
}

variable "create_secondary_global_replication_group" {
  description = "Determines whether an secondary ElastiCache global replication group will be created"
  type        = bool
  default     = false
}

################################################################################
# Parameter Group
################################################################################

variable "create_parameter_group" {
  description = "Determines whether the ElastiCache parameter group will be created or not"
  type        = bool
  default     = false
}

variable "parameter_group_description" {
  description = "The description of the ElastiCache parameter group. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "parameter_group_family" {
  description = "The family of the ElastiCache parameter group"
  type        = string
  default     = ""
}

variable "parameter_group_name" {
  description = "The name of the parameter group. If `create_parameter_group` is `true`, this is the name assigned to the parameter group created. Otherwise, this is the name of an existing parameter group"
  type        = string
  default     = null
}

variable "parameters" {
  description = "List of ElastiCache parameters to apply"
  type        = list(map(string))
  default     = []
}

################################################################################
# Subnet Group
################################################################################

variable "create_subnet_group" {
  description = "Determines whether the Elasticache subnet group will be created or not"
  type        = bool
  default     = true
}

variable "subnet_group_name" {
  description = "The name of the subnet group. If `create_subnet_group` is `true`, this is the name assigned to the subnet group created. Otherwise, this is the name of an existing subnet group"
  type        = string
  default     = null
}

variable "subnet_group_description" {
  description = "Description for the Elasticache subnet group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the Elasticache subnet group"
  type        = list(string)
  default     = []
}

################################################################################
# Security Group
################################################################################

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "Description of the security group created"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "Identifier of the VPC where the security group will be created"
  type        = string
  default     = null
}

variable "security_group_rules" {
  description = "Security group ingress and egress rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_tags" {
  description = "A map of additional tags to add to the security group created"
  type        = map(string)
  default     = {}
}
