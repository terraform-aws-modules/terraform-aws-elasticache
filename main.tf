locals {
  identifier           = var.replication_group_id != null ? var.replication_group_id : var.cluster_id
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

module "cluster" {
  source = "./modules/cluster"

  create               = var.cluster_id != null ? true : false
  cluster_id           = var.cluster_id
  replication_group_id = var.replication_group_id

  engine          = var.engine
  engine_version  = var.engine_version
  port            = var.port
  node_type       = var.node_type
  num_cache_nodes = var.num_cache_nodes

  subnet_group_name            = local.subnet_group_name
  az_mode                      = var.az_mode
  availability_zone            = var.availability_zone
  preferred_availability_zones = var.preferred_availability_zones
  security_group_ids           = var.security_group_ids

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
  availability_zones            = var.availability_zones

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
