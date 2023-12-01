output "name" {
  description = "The ElastiCache parameter group name"
  value       = element(concat(aws_elasticache_parameter_group.this.*.name, [""]), 0)
}

output "id" {
  description = "The ElastiCache parameter group id"
  value       = element(concat(aws_elasticache_parameter_group.this.*.id, [""]), 0)
}
