output "name" {
  description = "The ElastiCache subnet group name"
  value       = element(concat(aws_elasticache_subnet_group.this.*.name, [""]), 0)
}

output "ids" {
  description = "The ElastiCache subnet group IDs"
  value       = element(concat(aws_elasticache_subnet_group.this.*.subnet_ids, [""]), 0)
}
