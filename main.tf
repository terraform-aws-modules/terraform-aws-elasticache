locals {
  # https://github.com/hashicorp/terraform-provider-aws/blob/3c4cb52c5dc2c09e10e5a717f73d1d8bc4186e87/internal/service/elasticache/cluster.go#L271
  in_replication_group = var.replication_group_id != null

  port = var.engine == "memcached" ? 11211 : 6379
}

################################################################################
# Cluster
################################################################################

resource "aws_elasticache_cluster" "this" {
  count = var.create && var.create_cluster ? 1 : 0

  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  availability_zone          = var.availability_zone
  az_mode                    = local.in_replication_group ? null : var.az_mode
  cluster_id                 = var.cluster_id
  engine                     = var.engine
  engine_version             = local.in_replication_group ? null : var.engine_version
  final_snapshot_identifier  = var.final_snapshot_identifier
  ip_discovery               = var.ip_discovery

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration

    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = try(log_delivery_configuration.value.log_type, each.key)
    }
  }

  maintenance_window           = local.in_replication_group ? null : var.maintenance_window
  network_type                 = var.network_type
  node_type                    = local.in_replication_group ? null : var.node_type
  notification_topic_arn       = local.in_replication_group ? null : var.notification_topic_arn
  num_cache_nodes              = local.in_replication_group ? null : var.num_cache_nodes
  outpost_mode                 = var.outpost_mode
  parameter_group_name         = local.in_replication_group ? null : var.parameter_group_name
  port                         = local.in_replication_group ? null : coalesce(var.port, local.port)
  preferred_availability_zones = var.preferred_availability_zones
  preferred_outpost_arn        = var.preferred_outpost_arn
  replication_group_id         = var.create && var.create_replication_group ? aws_elasticache_replication_group.this[0].id : var.replication_group_id
  security_group_ids           = local.in_replication_group ? null : var.security_group_ids
  snapshot_arns                = local.in_replication_group ? null : var.snapshot_arns
  snapshot_name                = local.in_replication_group ? null : var.snapshot_name
  snapshot_retention_limit     = local.in_replication_group ? null : var.snapshot_retention_limit
  snapshot_window              = local.in_replication_group ? null : var.snapshot_window
  subnet_group_name            = local.in_replication_group ? null : var.subnet_group_name
  transit_encryption_enabled   = var.transit_encryption_enabled

  tags = var.tags
}

################################################################################
# Replication Group
################################################################################

locals {
  # https://github.com/hashicorp/terraform-provider-aws/blob/8c993e552d1396fac6f4706890bc7c9e44a852f3/internal/service/elasticache/replication_group.go#L130
  in_global_replication_group = var.global_replication_group_id != null
}

resource "aws_elasticache_replication_group" "this" {
  count = var.create && var.create_replication_group ? 1 : 0

  apply_immediately           = var.apply_immediately
  at_rest_encryption_enabled  = local.in_global_replication_group ? null : var.at_rest_encryption_enabled
  auth_token                  = var.auth_token
  auth_token_update_strategy  = var.auth_token_update_strategy
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  automatic_failover_enabled  = var.multi_az_enabled ? true : var.automatic_failover_enabled
  data_tiering_enabled        = var.data_tiering_enabled
  description                 = coalesce(var.description, "Replication group")
  engine                      = local.in_global_replication_group ? null : var.engine
  engine_version              = local.in_global_replication_group ? null : var.engine_version
  final_snapshot_identifier   = var.final_snapshot_identifier
  global_replication_group_id = var.global_replication_group_id
  ip_discovery                = var.ip_discovery
  kms_key_id                  = var.at_rest_encryption_enabled ? var.kms_key_arn : null

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration

    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = try(log_delivery_configuration.value.log_type, each.key)
    }
  }

  maintenance_window          = var.maintenance_window
  multi_az_enabled            = var.multi_az_enabled
  network_type                = var.network_type
  node_type                   = local.in_global_replication_group ? null : var.node_type
  notification_topic_arn      = var.notification_topic_arn
  num_cache_clusters          = var.num_cache_clusters
  num_node_groups             = local.in_global_replication_group ? null : var.num_node_groups
  parameter_group_name        = local.in_global_replication_group ? null : var.parameter_group_name
  port                        = coalesce(var.port, local.port)
  preferred_cache_cluster_azs = var.preferred_cache_cluster_azs
  replicas_per_node_group     = var.replicas_per_node_group
  replication_group_id        = var.replication_group_id
  security_group_names        = local.in_global_replication_group ? null : var.security_group_names
  security_group_ids          = var.security_group_ids
  snapshot_arns               = local.in_global_replication_group ? null : var.snapshot_arns
  snapshot_name               = local.in_global_replication_group ? null : var.snapshot_name
  snapshot_retention_limit    = var.snapshot_retention_limit
  snapshot_window             = var.snapshot_window
  subnet_group_name           = var.subnet_group_name
  transit_encryption_enabled  = local.in_global_replication_group ? null : var.transit_encryption_enabled
  user_group_ids              = var.user_group_ids

  tags = var.tags
}

################################################################################
# Parameter Group
################################################################################

resource "aws_elasticache_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  description = coalesce(var.parameter_group_description, "ElastiCache parameter group")
  family      = var.parameter_group_family
  name        = var.parameter_group_name

  dynamic "parameter" {
    for_each = var.parameters

    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}


################################################################################
# Subnet Group
################################################################################

locals {
  identifier           = local.in_replication_group ? var.replication_group_id : var.cluster_id
  subnet_group_name    = var.create_subnet_group ? module.subnet_group.name : var.subnet_group_name
  parameter_group_name = var.create_parameter_group ? module.parameter_group.id : var.parameter_group_name
}

module "subnet_group" {
  source = "./modules/subnet_group"

  create      = var.create_subnet_group
  identifier  = local.identifier
  name        = var.subnet_group_name
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids
}