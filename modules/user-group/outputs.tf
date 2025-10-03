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
  description = "A map of users created and their attributes"
  value       = aws_elasticache_user.this
  sensitive   = true
}
