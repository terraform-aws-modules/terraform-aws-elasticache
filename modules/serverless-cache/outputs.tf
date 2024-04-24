output "serverless_cache_arn" {
  description = "The amazon resource name of the serverless cache"
  value       = try(aws_elasticache_serverless_cache.this[0].arn, null)
}

output "serverless_cache_create_time" {
  description = "Timestamp of when the serverless cache was created"
  value       = try(aws_elasticache_serverless_cache.this[0].create_time, null)
}

output "serverless_cache_endpoint" {
  description = " Represents the information required for client programs to connect to a cache node"
  value       = try(aws_elasticache_serverless_cache.this[0].endpoint, null)
}

output "serverless_cache_full_engine_version" {
  description = "The name and version number of the engine the serverless cache is compatible with"
  value       = try(aws_elasticache_serverless_cache.this[0].full_engine_version, null)
}

output "serverless_cache_major_engine_version" {
  description = "The version number of the engine the serverless cache is compatible with"
  value       = try(aws_elasticache_serverless_cache.this[0].major_engine_version, null)
}

output "serverless_cache_reader_endpoint" {
  description = "Represents the information required for client programs to connect to a cache node"
  value       = try(aws_elasticache_serverless_cache.this[0].reader_endpoint, null)
}

output "serverless_cache_status" {
  description = "The current status of the serverless cache. The allowed values are CREATING, AVAILABLE, DELETING, CREATE-FAILED and MODIFYING"
  value       = try(aws_elasticache_serverless_cache.this[0].status, null)
}
