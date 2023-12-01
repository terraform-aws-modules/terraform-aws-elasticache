variable "create" {
  description = "Determines whether the Elasticache subnet group will be created or not"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The identifier of the resource"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name for the Elasticache subnet group. Elasticache converts this name to lowercase"
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the Elasticache subnet group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the Elasticache subnet group "
  type        = list(string)
  default     = []
}
