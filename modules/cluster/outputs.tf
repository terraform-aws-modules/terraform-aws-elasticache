output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone. Referenceable e.g. as `aws_elasticache_cluster.bar.cache_nodes.0.address`"
  value       = element(concat(aws_elasticache_cluster.redis.*.cache_nodes, aws_elasticache_cluster.memcached.*.cache_nodes, [""]), 0)
}

output "configuration_endpoint" {
  description = "The configuration endpoint to allow host discovery"
  value       = element(concat(aws_elasticache_cluster.memcached.*.configuration_endpoint, [""]), 0)
}

output "cluster_address" {
  description = "The DNS name of the cache cluster without the port appended"
  value       = element(concat(aws_elasticache_cluster.memcached.*.cluster_address, [""]), 0)
}
