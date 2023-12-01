################################################################################
# Cluster
################################################################################

output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone"
  value       = module.memcached_cluster.cluster_cache_nodes
}

output "configuration_endpoint" {
  description = "The configuration endpoint to allow host discovery"
  value       = module.memcached_cluster.cluster_configuration_endpoint
}

output "address" {
  description = "The DNS name of the cache cluster without the port appended"
  value       = module.memcached_cluster.cluster_address
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.memcached_cluster.subnet_group_name
}

output "subnet_group_ids" {
  description = "The ElastiCache subnet group IDs"
  value       = module.memcached_cluster.subnet_group_ids
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_name" {
  description = "The ElastiCache parameter group name"
  value       = module.memcached_cluster.parameter_group_name
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group id"
  value       = module.memcached_cluster.parameter_group_id
}
