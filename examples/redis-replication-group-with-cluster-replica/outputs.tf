################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The ARN of the ElastiCache Cluster"
  value       = module.replication_group_with_cluster_replica.cluster_arn
}

output "cluster_engine_version_actual" {
  description = "Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine"
  value       = module.replication_group_with_cluster_replica.cluster_engine_version_actual
}

output "cluster_cache_nodes" {
  description = "List of node objects including `id`, `address`, `port` and `availability_zone`"
  value       = module.replication_group_with_cluster_replica.cluster_cache_nodes
}

output "cluster_address" {
  description = "(Memcached only) DNS name of the cache cluster without the port appended"
  value       = module.replication_group_with_cluster_replica.cluster_address
}

output "cluster_configuration_endpoint" {
  description = "(Memcached only) Configuration endpoint to allow host discovery"
  value       = module.replication_group_with_cluster_replica.cluster_configuration_endpoint
}

################################################################################
# Replication Group
################################################################################

output "replication_group_arn" {
  description = "ARN of the created ElastiCache Replication Group"
  value       = module.replication_group_with_cluster_replica.replication_group_arn
}

output "replication_group_engine_version_actual" {
  description = "Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine"
  value       = module.replication_group_with_cluster_replica.replication_group_engine_version_actual
}

output "replication_group_configuration_endpoint_address" {
  description = "Address of the replication group configuration endpoint when cluster mode is enabled"
  value       = module.replication_group_with_cluster_replica.replication_group_configuration_endpoint_address
}

output "replication_group_id" {
  description = "ID of the ElastiCache Replication Group"
  value       = module.replication_group_with_cluster_replica.replication_group_id
}

output "replication_group_member_clusters" {
  description = "Identifiers of all the nodes that are part of this replication group"
  value       = module.replication_group_with_cluster_replica.replication_group_member_clusters
}

output "replication_group_primary_endpoint_address" {
  description = "Address of the endpoint for the primary node in the replication group, if the cluster mode is disabled"
  value       = module.replication_group_with_cluster_replica.replication_group_primary_endpoint_address
}

output "replication_group_reader_endpoint_address" {
  description = "Address of the endpoint for the reader node in the replication group, if the cluster mode is disabled"
  value       = module.replication_group_with_cluster_replica.replication_group_reader_endpoint_address
}

################################################################################
# Global Replication Group
################################################################################

output "global_replication_group_id" {
  description = "ID of the ElastiCache Global Replication Group"
  value       = module.replication_group_with_cluster_replica.global_replication_group_id
}

output "global_replication_group_arn" {
  description = "ARN of the created ElastiCache Global Replication Group"
  value       = module.replication_group_with_cluster_replica.global_replication_group_arn
}

output "global_replication_group_engine_version_actual" {
  description = "The full version number of the cache engine running on the members of this global replication group"
  value       = module.replication_group_with_cluster_replica.global_replication_group_engine_version_actual
}

output "global_replication_group_node_groups" {
  description = "Set of node groups (shards) on the global replication group"
  value       = module.replication_group_with_cluster_replica.global_replication_group_node_groups
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.replication_group_with_cluster_replica.cloudwatch_log_groups
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_arn" {
  description = "The AWS ARN associated with the parameter group"
  value       = module.replication_group_with_cluster_replica.parameter_group_arn
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group name"
  value       = module.replication_group_with_cluster_replica.parameter_group_id
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.replication_group_with_cluster_replica.subnet_group_name
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.replication_group_with_cluster_replica.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.replication_group_with_cluster_replica.security_group_id
}
