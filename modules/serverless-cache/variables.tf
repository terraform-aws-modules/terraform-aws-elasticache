variable "create" {
  description = "Determines whether serverless resource will be created."
  type        = bool
  default     = true
}

variable "cache_name" {
  description = "The name which serves as a unique identifier to the serverless cache."
  type        = string
  default     = null
}

variable "cache_usage_limits" {
  description = "Sets the cache usage limits for storage and ElastiCache Processing Units for the cache."
  type        = map(any)
  default     = {}
}

variable "daily_snapshot_time" {
  description = "The daily time that snapshots will be created from the new serverless cache. Only supported for engine type `redis`. Defaults to 0."
  type        = string
  default     = null
}

variable "description" {
  description = "User-created description for the serverless cache."
  type        = string
  default     = null
}

variable "engine" {
  description = "Name of the cache engine to be used for this cache cluster. Valid values are `memcached` or `redis`."
  type        = string
  default     = "redis"
}

variable "kms_key_id" {
  description = "ARN of the customer managed key for encrypting the data at rest. If no KMS key is provided, a default service key is used."
  type        = string
  default     = null
}

variable "major_engine_version" {
  description = "The version of the cache engine that will be used to create the serverless cache."
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the serverless cache."
  type        = list(string)
  default     = []
}

variable "snapshot_arns_to_restore" {
  description = "The list of ARN(s) of the snapshot that the new serverless cache will be created from. Available for Redis only."
  type        = list(string)
  default     = null
}

variable "snapshot_retention_limit" {
  description = "(Redis only) The number of snapshots that will be retained for the serverless cache that is being created."
  type        = number
  default     = null
}

variable "subnet_ids" {
  description = "A list of the identifiers of the subnets where the VPC endpoint for the serverless cache will be deployed."
  type        = list(string)
  default     = []
}

variable "user_group_id" {
  description = "The identifier of the UserGroup to be associated with the serverless cache. Available for Redis only. Default is NULL."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting serverless resources."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
