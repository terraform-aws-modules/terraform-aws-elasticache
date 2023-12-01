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

variable "apply_immediately" {
  description = "Whether any database modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type `redis` and if the engine version is 6 or higher. Defaults to `true`"
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
  description = "Name of the cache engine to be used for this cache cluster. Valid values are `memcached` or `redis`"
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
  description = "(Redis only) Specifies the destination and format of Redis SLOWLOG or Redis Engine Log"
  type        = list(map(string))
  default     = []
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

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this cache cluster"
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

variable "subnet_group_name" {
  description = "Name of the subnet group to be used for the cache cluster. Changing this value will re-create the resource"
  type        = string
  default     = null
}

variable "transit_encryption_enabled" {
  description = "Enable encryption in-transit. Supported only with Memcached versions `1.6.12` and later, running in a VPC"
  type        = bool
  default     = null
}

################################################################################
# Replication Group
################################################################################

variable "create_replication_group" {
  description = "Determines whether an ElastiCache replication group will be created or not"
  type        = bool
  default     = false
}

variable "replication_group_id" {
  description = "The replication group identifier. This parameter is stored as a lowercase string"
  type        = string
  default     = null
}

variable "replication_group_description" {
  description = "A user-created description for the replication group"
  type        = string
  default     = null
}

variable "number_cache_clusters" {
  description = "(Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications"
  type        = number
  default     = null
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups"
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "auth_token" {
  description = "The password used to access a password protected server. Can be specified only if `transit_encryption_enabled = true`"
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if `at_rest_encryption_enabled = true`"
  type        = string
  default     = null
}

variable "security_group_names" {
  description = "A list of cache security group names to associate with this replication group"
  type        = list(string)
  default     = []
}

variable "cluster_mode" {
  description = "Create a native redis cluster. automatic_failover_enabled must be set to true. Cluster Mode documented below. Only 1 cluster_mode block is allowed"
  type        = list(map(string))
  default     = []
}

################################################################################
# Parameter Group
################################################################################

variable "parameter_group_family" {
  description = "The family of the ElastiCache parameter group"
  type        = string
  default     = null
}

variable "create_parameter_group" {
  description = "Determines whether the ElastiCache parameter group will be created or not"
  type        = bool
  default     = false
}

variable "parameter_group_description" {
  description = "Description for the ElastiCache parameter group"
  type        = string
  default     = ""
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
  default     = false
}

variable "subnet_group_description" {
  description = "Description for the Elasticache subnet group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the Elasticache subnet group "
  type        = list(string)
  default     = []
}
