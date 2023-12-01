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
  default     = "REDIS"
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
