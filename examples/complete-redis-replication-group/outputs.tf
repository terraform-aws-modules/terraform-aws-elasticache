################################################################################
# Replication Group
################################################################################

output "id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = module.redis_repl_group.replication_group_id
}

output "endpoint_address" {
  description = "The address of the replication group configuration endpoint when cluster mode is enabled"
  value       = module.redis_repl_group.replication_group_configuration_endpoint_address
}

output "primary_endpoint_address" {
  description = "The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled"
  value       = module.redis_repl_group.replication_group_primary_endpoint_address
}

output "member_clusters" {
  description = "The identifiers of all the nodes that are part of this replication group. "
  value       = module.redis_repl_group.replication_group_member_clusters
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.redis_repl_group.subnet_group_name
}

output "subnet_group_ids" {
  description = "The ElastiCache subnet group IDs"
  value       = module.redis_repl_group.subnet_group_ids
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_name" {
  description = "The ElastiCache parameter group name"
  value       = module.redis_repl_group.parameter_group_name
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group id"
  value       = module.redis_repl_group.parameter_group_id
}
