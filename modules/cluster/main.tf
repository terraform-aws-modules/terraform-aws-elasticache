locals {
  cluster_id      = var.cluster_id != null ? lower(var.cluster_id) : ""
  num_cache_nodes = var.replication_group_id != null ? null : var.num_cache_nodes
}

resource "aws_elasticache_cluster" "redis" {
  count = var.create && var.engine == "redis" ? 1 : 0

  cluster_id           = local.cluster_id
  replication_group_id = var.replication_group_id

  engine          = "redis"
  engine_version  = var.engine_version
  port            = var.replication_group_id != null ? null : coalesce(var.port, 6379)
  node_type       = var.node_type
  num_cache_nodes = local.num_cache_nodes

  subnet_group_name  = var.subnet_group_name
  availability_zone  = var.availability_zone
  security_group_ids = var.security_group_ids

  maintenance_window   = var.maintenance_window
  parameter_group_name = var.parameter_group_name
  apply_immediately    = var.apply_immediately

  snapshot_arns            = var.snapshot_arns
  snapshot_name            = var.snapshot_name
  snapshot_window          = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit
  notification_topic_arn   = var.notification_topic_arn

  tags = merge({ Name = local.cluster_id }, var.tags)
}

resource "aws_elasticache_cluster" "memcached" {
  count = var.create && var.engine == "memcached" ? 1 : 0

  cluster_id           = local.cluster_id
  replication_group_id = var.replication_group_id

  engine          = "memcached"
  engine_version  = var.engine_version
  port            = var.replication_group_id != null ? null : coalesce(var.port, 11211)
  node_type       = var.node_type
  num_cache_nodes = local.num_cache_nodes

  subnet_group_name            = var.subnet_group_name
  az_mode                      = var.az_mode
  availability_zone            = var.availability_zone
  preferred_availability_zones = var.preferred_availability_zones
  security_group_ids           = var.security_group_ids

  maintenance_window   = var.maintenance_window
  parameter_group_name = var.parameter_group_name
  apply_immediately    = var.apply_immediately

  snapshot_arns          = var.snapshot_arns
  snapshot_name          = var.snapshot_name
  notification_topic_arn = var.notification_topic_arn

  tags = merge({ Name = local.cluster_id }, var.tags)
}