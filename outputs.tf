
################################################################################
# Cluster
################################################################################

output "arn" {
  description = "The ARN of the ElastiCache Cluster"
  value       = try(aws_elasticache_cluster.this[0].arn, null)
}

output "engine_version_actual" {
  description = "Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine"
  value       = try(aws_elasticache_cluster.this[0].engine_version_actual, null)
}

output "cache_nodes" {
  description = "List of node objects including `id`, `address`, `port` and `availability_zone`"
  value       = try(aws_elasticache_cluster.this[0].cache_nodes, null)
}

output "address" {
  description = "(Memcached only) DNS name of the cache cluster without the port appended"
  value       = try(aws_elasticache_cluster.this[0].cluster_address, null)
}

output "configuration_endpoint" {
  description = "(Memcached only) Configuration endpoint to allow host discovery"
  value       = try(aws_elasticache_cluster.this[0].configuration_endpoint, null)
}

################################################################################
# Replication Group
################################################################################

output "replication_group_id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = module.replication_group.id
}

output "replication_group_configuration_endpoint_address" {
  description = "The address of the replication group configuration endpoint when cluster mode is enabled"
  value       = module.replication_group.configuration_endpoint_address
}

output "replication_group_primary_endpoint_address" {
  description = "The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled"
  value       = module.replication_group.primary_endpoint_address
}

output "replication_group_member_clusters" {
  description = "The identifiers of all the nodes that are part of this replication group. "
  value       = module.replication_group.member_clusters
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.subnet_group.name
}

output "subnet_group_ids" {
  description = "The ElastiCache subnet group IDs"
  value       = module.subnet_group.ids
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_name" {
  description = "The ElastiCache parameter group name"
  value       = module.parameter_group.name
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group id"
  value       = module.parameter_group.id
}
