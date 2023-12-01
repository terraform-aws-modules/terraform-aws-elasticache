################################################################################
# Cluster
################################################################################

output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone"
  value       = module.redis_cluster.cluster_cache_nodes
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.redis_cluster.subnet_group_name
}

output "subnet_group_ids" {
  description = "The ElastiCache subnet group IDs"
  value       = module.redis_cluster.subnet_group_ids
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_name" {
  description = "The ElastiCache parameter group name"
  value       = module.redis_cluster.parameter_group_name
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group id"
  value       = module.redis_cluster.parameter_group_id
}
