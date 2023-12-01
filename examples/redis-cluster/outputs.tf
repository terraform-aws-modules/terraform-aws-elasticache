################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The ARN of the ElastiCache Cluster"
  value       = module.elasticache.cluster_arn
}

output "cluster_engine_version_actual" {
  description = "Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine"
  value       = module.elasticache.cluster_engine_version_actual
}

output "cluster_cache_nodes" {
  description = "List of node objects including `id`, `address`, `port` and `availability_zone`"
  value       = module.elasticache.cluster_cache_nodes
}

output "cluster_address" {
  description = "(Memcached only) DNS name of the cache cluster without the port appended"
  value       = module.elasticache.cluster_address
}

output "cluster_configuration_endpoint" {
  description = "(Memcached only) Configuration endpoint to allow host discovery"
  value       = module.elasticache.cluster_configuration_endpoint
}

################################################################################
# Replication Group
################################################################################

output "rep_group_arn" {
  description = "ARN of the created ElastiCache Replication Group"
  value       = module.elasticache.rep_group_arn
}

output "rep_group_engine_version_actual" {
  description = "Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine"
  value       = module.elasticache.rep_group_engine_version_actual
}

output "rep_group_coniguration_endpoint_address" {
  description = "Address of the replication group configuration endpoint when cluster mode is enabled"
  value       = module.elasticache.rep_group_coniguration_endpoint_address
}

output "rep_group_id" {
  description = "ID of the ElastiCache Replication Group"
  value       = module.elasticache.rep_group_id
}

output "rep_group_member_clusters" {
  description = "Identifiers of all the nodes that are part of this replication group"
  value       = module.elasticache.rep_group_member_clusters
}

output "rep_group_primary_endpoint_address" {
  description = "Address of the endpoint for the primary node in the replication group, if the cluster mode is disabled"
  value       = module.elasticache.rep_group_primary_endpoint_address
}

output "rep_group_reader_endpoint_address" {
  description = "Address of the endpoint for the reader node in the replication group, if the cluster mode is disabled"
  value       = module.elasticache.rep_group_reader_endpoint_address
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.elasticache.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.elasticache.cloudwatch_log_group_arn
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_arn" {
  description = "The AWS ARN associated with the parameter group"
  value       = module.elasticache.parameter_group_arn
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group name"
  value       = module.elasticache.parameter_group_id
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.elasticache.subnet_group_name
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.elasticache.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.elasticache.security_group_id
}
