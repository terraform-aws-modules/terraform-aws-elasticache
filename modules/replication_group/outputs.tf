output "id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = element(concat(aws_elasticache_replication_group.this.*.id, [""]), 0)
}

output "configuration_endpoint_address" {
  description = "The address of the replication group configuration endpoint when cluster mode is enabled"
  value       = element(concat(aws_elasticache_replication_group.this.*.configuration_endpoint_address, [""]), 0)
}

output "primary_endpoint_address" {
  description = "The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled"
  value       = element(concat(aws_elasticache_replication_group.this.*.primary_endpoint_address, [""]), 0)
}

output "member_clusters" {
  description = "The identifiers of all the nodes that are part of this replication group. "
  value       = element(concat(aws_elasticache_replication_group.this.*.member_clusters, [""]), 0)
}
