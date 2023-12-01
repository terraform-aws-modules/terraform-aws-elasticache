variable "create" {
  description = "Determines whether the ElastiCache parameter group will be created or not"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The identifier of the resource"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name for the ElastiCache parameter group"
  type        = string
  default     = null
}

variable "family" {
  description = "The family of the ElastiCache parameter group"
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the ElastiCache parameter group"
  type        = string
  default     = null
}

variable "parameters" {
  description = "List of ElastiCache parameters to apply"
  type        = list(map(string))
  default     = []
}

variable "cluster_mode_enabled" {
  description = "If cluster mode is enabled, add in `cluster-enabled` parameter, otherwise omit"
  type        = bool
  default     = false
}
