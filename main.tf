locals {
  # https://github.com/hashicorp/terraform-provider-aws/blob/3c4cb52c5dc2c09e10e5a717f73d1d8bc4186e87/internal/service/elasticache/cluster.go#L271
  in_replication_group = var.replication_group_id != null

  port = var.engine == "memcached" ? 11211 : 6379
}

################################################################################
# Cluster
################################################################################

resource "aws_elasticache_cluster" "this" {
  count = var.create ? 1 : 0

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
  replication_group_id         = var.replication_group_id
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

module "parameter_group" {
  source = "./modules/parameter_group"

  create      = var.create_parameter_group
  identifier  = local.identifier
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = var.parameter_group_description
  parameters  = var.parameters
}

module "replication_group" {
  source = "./modules/replication_group"

  create                     = var.create_replication_group
  engine_version             = var.engine_version
  port                       = var.port
  node_type                  = var.node_type
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  automatic_failover_enabled    = var.automatic_failover_enabled
  # availability_zones            = var.availability_zones

  number_cache_clusters = var.number_cache_clusters
  cluster_mode          = var.cluster_mode

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  kms_key_id                 = var.kms_key_id
  auth_token                 = var.auth_token

  subnet_group_name    = local.subnet_group_name
  security_group_names = var.security_group_names
  security_group_ids   = var.security_group_ids

  maintenance_window   = var.maintenance_window
  parameter_group_name = local.parameter_group_name
  apply_immediately    = var.apply_immediately

  snapshot_arns            = var.snapshot_arns
  snapshot_name            = var.snapshot_name
  snapshot_window          = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit
  notification_topic_arn   = var.notification_topic_arn

  tags = var.tags
}
