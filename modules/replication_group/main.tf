locals {
  temp_id     = var.replication_group_id != null ? var.replication_group_id : "none"
  description = var.replication_group_description != null ? var.replication_group_description : "Replication group for ${local.temp_id}"
}

resource "aws_elasticache_replication_group" "this" {
  count = var.create ? 1 : 0

  engine                     = "redis"
  engine_version             = var.engine_version
  port                       = var.port
  node_type                  = var.node_type
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  replication_group_id          = var.replication_group_id
  replication_group_description = local.description
  automatic_failover_enabled    = var.automatic_failover_enabled
  availability_zones            = var.availability_zones

  number_cache_clusters = var.number_cache_clusters
  dynamic "cluster_mode" {
    for_each = var.cluster_mode
    content {
      replicas_per_node_group = cluster_mode.value.replicas_per_node_group
      num_node_groups         = cluster_mode.value.num_node_groups
    }
  }

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  kms_key_id                 = var.kms_key_id
  auth_token                 = var.transit_encryption_enabled ? var.auth_token : null

  parameter_group_name = var.parameter_group_name
  subnet_group_name    = var.subnet_group_name
  security_group_names = var.security_group_names
  security_group_ids   = var.security_group_ids

  snapshot_arns            = var.snapshot_arns
  snapshot_name            = var.snapshot_name
  apply_immediately        = var.apply_immediately
  maintenance_window       = var.maintenance_window
  notification_topic_arn   = var.notification_topic_arn
  snapshot_window          = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit

  tags = merge({ Name = var.replication_group_id }, var.tags)
}
