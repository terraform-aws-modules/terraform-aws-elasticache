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
# Group
################################################################################

variable "create_group" {
  description = "Determines whether a user group will be created"
  type        = bool
  default     = true
}

variable "engine" {
  description = "The current supported value is `REDIS`"
  type        = string
  default     = "redis"
}

variable "user_group_id" {
  description = "The ID of the user group"
  type        = string
  default     = ""
}

################################################################################
# User(s)
################################################################################

variable "users" {
  description = "A map of users to create"
  type        = any
  default     = {}
}

variable "create_default_user" {
  description = "Determines whether a default user will be created"
  type        = bool
  default     = true
}

variable "default_user" {
  description = "A map of default user attributes"
  type        = any
  default     = {}
}

variable "default_user_id" {
  description = "The ID of the default user"
  type        = string
  default     = "default"
}
