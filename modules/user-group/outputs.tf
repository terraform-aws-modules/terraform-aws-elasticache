################################################################################
# Group
################################################################################

output "group_arn" {
  description = "The ARN that identifies the user group"
  value       = try(aws_elasticache_user_group.this[0].arn, null)
}

output "group_id" {
  description = "The user group identifier"
  value       = try(aws_elasticache_user_group.this[0].id, null)
}

################################################################################
# User(s)
################################################################################

output "users" {
  description = "A sensitive map of users created and all of their resource attributes"
  value       = aws_elasticache_user.this
  sensitive   = true
}

output "users_metadata" {
  description = "A map of users created and their non-sensitive identifiers"

  value = {
    for key, user in aws_elasticache_user.this : key => {
      arn       = user.arn
      id        = user.id
      user_id   = user.user_id
      user_name = user.user_name
    }
  }
}

output "default_user_arn" {
  description = "ARN of the default user"
  value       = try(aws_elasticache_user.default[0].arn, null)
}
