locals {
  # https://github.com/hashicorp/terraform-provider-aws/blob/3c4cb52c5dc2c09e10e5a717f73d1d8bc4186e87/internal/service/elasticache/cluster.go#L271
  in_replication_group = var.replication_group_id != null

  # elasticache clusters currently do not support engine type valkey
  # TODO: remove this local `create_cluster` conditional once this bug is addressed:
  # https://github.com/hashicorp/terraform-provider-aws/issues/39905
  create_cluster = var.create_cluster && var.engine != "valkey" ? true : false

  security_group_ids = local.create_security_group ? concat(var.security_group_ids, [aws_security_group.this[0].id]) : var.security_group_ids
  port               = var.engine == "memcached" ? 11211 : 6379

  tags = merge(var.tags, { terraform-aws-modules = "elasticache" })
}

################################################################################
# Cluster
################################################################################

resource "aws_elasticache_cluster" "this" {
  count = var.create && local.create_cluster ? 1 : 0

  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  availability_zone          = var.availability_zone
  az_mode                    = local.in_replication_group ? null : var.az_mode
  cluster_id                 = var.cluster_id
  engine                     = local.in_replication_group ? null : var.engine
  engine_version             = local.in_replication_group ? null : var.engine_version
  final_snapshot_identifier  = var.final_snapshot_identifier
  ip_discovery               = var.ip_discovery

  dynamic "log_delivery_configuration" {
    for_each = { for k, v in var.log_delivery_configuration : k => v if var.engine != "memcached" && !local.in_replication_group }

    content {
      destination      = try(log_delivery_configuration.value.create_cloudwatch_log_group, true) && log_delivery_configuration.value.destination_type == "cloudwatch-logs" ? aws_cloudwatch_log_group.this[log_delivery_configuration.key].name : log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = try(log_delivery_configuration.value.log_type, log_delivery_configuration.key)
    }
  }

  maintenance_window           = local.in_replication_group ? null : var.maintenance_window
  network_type                 = var.network_type
  node_type                    = local.in_replication_group ? null : var.node_type
  notification_topic_arn       = local.in_replication_group ? null : var.notification_topic_arn
  num_cache_nodes              = local.in_replication_group ? null : var.num_cache_nodes
  outpost_mode                 = var.outpost_mode
  parameter_group_name         = local.in_replication_group ? null : local.parameter_group_name_result
  port                         = local.in_replication_group ? null : coalesce(var.port, local.port)
  preferred_availability_zones = var.preferred_availability_zones
  preferred_outpost_arn        = var.preferred_outpost_arn
  replication_group_id         = var.create && var.create_replication_group ? aws_elasticache_replication_group.this[0].id : var.replication_group_id
  security_group_ids           = local.in_replication_group ? null : local.security_group_ids
  snapshot_arns                = local.in_replication_group ? null : var.snapshot_arns
  snapshot_name                = local.in_replication_group ? null : var.snapshot_name
  snapshot_retention_limit     = local.in_replication_group ? null : var.snapshot_retention_limit
  snapshot_window              = local.in_replication_group ? null : var.snapshot_window
  subnet_group_name            = local.in_replication_group ? null : local.subnet_group_name
  transit_encryption_enabled   = var.engine == "memcached" ? var.transit_encryption_enabled : null

  tags = local.tags
}

################################################################################
# Replication Group
################################################################################

locals {
  num_node_groups = var.cluster_mode_enabled ? var.num_node_groups : null
}

resource "aws_elasticache_replication_group" "this" {
  count = var.create && var.create_replication_group && !local.create_global_replication_group ? 1 : 0

  apply_immediately           = var.apply_immediately
  at_rest_encryption_enabled  = var.at_rest_encryption_enabled
  auth_token                  = var.auth_token
  auth_token_update_strategy  = var.auth_token_update_strategy
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  automatic_failover_enabled  = var.multi_az_enabled || var.cluster_mode_enabled ? true : var.automatic_failover_enabled
  cluster_mode                = var.cluster_mode
  data_tiering_enabled        = var.data_tiering_enabled
  description                 = coalesce(var.description, "Replication group")
  engine                      = var.engine
  engine_version              = var.engine_version
  final_snapshot_identifier   = var.final_snapshot_identifier
  global_replication_group_id = var.global_replication_group_id
  ip_discovery                = var.ip_discovery
  kms_key_id                  = var.at_rest_encryption_enabled ? var.kms_key_arn : null

  dynamic "log_delivery_configuration" {
    for_each = { for k, v in var.log_delivery_configuration : k => v if var.engine != "memcached" }

    content {
      destination      = try(log_delivery_configuration.value.create_cloudwatch_log_group, true) && log_delivery_configuration.value.destination_type == "cloudwatch-logs" ? aws_cloudwatch_log_group.this[log_delivery_configuration.key].name : log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = try(log_delivery_configuration.value.log_type, log_delivery_configuration.key)
    }
  }

  maintenance_window          = var.maintenance_window
  multi_az_enabled            = var.multi_az_enabled
  network_type                = var.network_type
  node_type                   = var.node_type
  notification_topic_arn      = var.notification_topic_arn
  num_cache_clusters          = var.cluster_mode_enabled ? null : var.num_cache_clusters
  num_node_groups             = local.num_node_groups
  parameter_group_name        = local.parameter_group_name_result
  port                        = coalesce(var.port, local.port)
  preferred_cache_cluster_azs = var.preferred_cache_cluster_azs
  replicas_per_node_group     = var.replicas_per_node_group
  replication_group_id        = var.replication_group_id
  security_group_names        = var.security_group_names
  security_group_ids          = local.security_group_ids
  snapshot_arns               = var.snapshot_arns
  snapshot_name               = var.snapshot_name
  snapshot_retention_limit    = var.snapshot_retention_limit
  snapshot_window             = var.snapshot_window
  subnet_group_name           = local.subnet_group_name
  transit_encryption_enabled  = var.transit_encryption_enabled
  transit_encryption_mode     = var.transit_encryption_mode
  user_group_ids              = var.user_group_ids

  tags = local.tags
}

################################################################################
# Global Replication Group
################################################################################

locals {
  create_global_replication_group = var.create_primary_global_replication_group || var.create_secondary_global_replication_group

}

resource "aws_elasticache_global_replication_group" "this" {
  count = var.create && var.create_replication_group && var.create_primary_global_replication_group ? 1 : 0

  automatic_failover_enabled = var.automatic_failover_enabled
  cache_node_type            = var.node_type
  engine_version             = var.engine_version

  global_replication_group_id_suffix   = var.replication_group_id
  global_replication_group_description = coalesce(var.description, "Global replication group")
  primary_replication_group_id         = aws_elasticache_replication_group.global[0].id
  parameter_group_name                 = local.parameter_group_name_result
}

resource "aws_elasticache_replication_group" "global" {
  count = var.create && var.create_replication_group && local.create_global_replication_group ? 1 : 0

  apply_immediately           = var.apply_immediately
  at_rest_encryption_enabled  = var.create_secondary_global_replication_group ? null : var.at_rest_encryption_enabled
  auth_token                  = var.auth_token
  auth_token_update_strategy  = var.auth_token_update_strategy
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  automatic_failover_enabled  = var.multi_az_enabled || var.cluster_mode_enabled ? true : var.automatic_failover_enabled
  cluster_mode                = var.cluster_mode
  data_tiering_enabled        = var.data_tiering_enabled
  description                 = coalesce(var.description, "Global replication group")
  engine                      = var.create_secondary_global_replication_group ? null : var.engine
  engine_version              = var.create_secondary_global_replication_group ? null : var.engine_version
  final_snapshot_identifier   = var.final_snapshot_identifier
  global_replication_group_id = var.create_secondary_global_replication_group ? var.global_replication_group_id : null
  ip_discovery                = var.ip_discovery
  kms_key_id                  = var.at_rest_encryption_enabled ? var.kms_key_arn : null

  dynamic "log_delivery_configuration" {
    for_each = { for k, v in var.log_delivery_configuration : k => v if var.engine != "memcached" }

    content {
      destination      = try(log_delivery_configuration.value.create_cloudwatch_log_group, true) && log_delivery_configuration.value.destination_type == "cloudwatch-logs" ? aws_cloudwatch_log_group.this[log_delivery_configuration.key].name : log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = try(log_delivery_configuration.value.log_type, log_delivery_configuration.key)
    }
  }

  maintenance_window          = var.maintenance_window
  multi_az_enabled            = var.multi_az_enabled
  network_type                = var.network_type
  node_type                   = var.node_type
  notification_topic_arn      = var.notification_topic_arn
  num_cache_clusters          = var.cluster_mode_enabled ? null : var.num_cache_clusters
  num_node_groups             = var.create_secondary_global_replication_group ? null : local.num_node_groups
  parameter_group_name        = var.create_secondary_global_replication_group ? null : local.parameter_group_name_result
  port                        = coalesce(var.port, local.port)
  preferred_cache_cluster_azs = var.preferred_cache_cluster_azs
  replicas_per_node_group     = var.replicas_per_node_group
  replication_group_id        = var.replication_group_id
  security_group_names        = var.create_secondary_global_replication_group ? null : var.security_group_names
  security_group_ids          = local.security_group_ids
  snapshot_arns               = var.create_secondary_global_replication_group ? null : var.snapshot_arns
  snapshot_name               = var.create_secondary_global_replication_group ? null : var.snapshot_name
  snapshot_retention_limit    = var.snapshot_retention_limit
  snapshot_window             = var.snapshot_window
  subnet_group_name           = local.subnet_group_name
  transit_encryption_enabled  = var.create_secondary_global_replication_group ? null : var.transit_encryption_enabled
  user_group_ids              = var.user_group_ids

  tags = local.tags

  lifecycle {
    ignore_changes = [engine_version]
  }
}

################################################################################
# Cloudwatch Log Group
################################################################################

locals {
  create_cloudwatch_log_group = var.create && var.engine != "memcached"
}

resource "aws_cloudwatch_log_group" "this" {
  for_each = { for k, v in var.log_delivery_configuration : k => v if local.create_cloudwatch_log_group && try(v.create_cloudwatch_log_group, true) && try(v.destination_type, "") == "cloudwatch-logs" }

  name              = "/aws/elasticache/${try(each.value.cloudwatch_log_group_name, coalesce(var.cluster_id, var.replication_group_id), "")}"
  retention_in_days = try(each.value.cloudwatch_log_group_retention_in_days, 14)
  kms_key_id        = try(each.value.cloudwatch_log_group_kms_key_id, null)
  skip_destroy      = try(each.value.cloudwatch_log_group_skip_destroy, null)
  log_group_class   = try(each.value.cloudwatch_log_group_class, null)

  tags = merge(local.tags, try(each.value.tags, {}))
}

################################################################################
# Parameter Group
################################################################################

resource "random_id" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  byte_length = 8
}

locals {
  inter_parameter_group_name  = "${try(coalesce(var.cluster_id, var.replication_group_id), "")}-${replace(var.parameter_group_family, ".", "-")}-${try(random_id.this[0].hex, "")}"
  parameter_group_name        = coalesce(var.parameter_group_name, local.inter_parameter_group_name)
  parameter_group_name_result = var.create && var.create_parameter_group ? aws_elasticache_parameter_group.this[0].id : var.parameter_group_name

  parameters = var.cluster_mode_enabled ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameters) : var.parameters
}

resource "aws_elasticache_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  description = coalesce(var.parameter_group_description, "ElastiCache parameter group")
  family      = var.parameter_group_family
  name        = local.parameter_group_name

  dynamic "parameter" {
    for_each = local.parameters

    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# Subnet Group
################################################################################

locals {
  inter_subnet_group_name = try(coalesce(var.subnet_group_name, var.cluster_id, var.replication_group_id), "")
  subnet_group_name       = var.create && var.create_subnet_group ? aws_elasticache_subnet_group.this[0].name : var.subnet_group_name
}

resource "aws_elasticache_subnet_group" "this" {
  count = var.create && var.create_subnet_group ? 1 : 0

  name        = local.inter_subnet_group_name
  description = coalesce(var.subnet_group_description, "ElastiCache subnet group")
  subnet_ids  = var.subnet_ids

  tags = local.tags
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.cluster_id, var.replication_group_id), "")
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = merge(local.tags, var.security_group_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if local.create_security_group && try(v.type, "ingress") == "ingress" }

  # Required
  security_group_id = aws_security_group.this[0].id
  ip_protocol       = try(each.value.ip_protocol, "tcp")

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6                    = lookup(each.value, "cidr_ipv6", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, local.port)
  prefix_list_id               = lookup(each.value, "prefix_list_id", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  to_port                      = try(each.value.to_port, local.port)

  tags = merge(local.tags, var.security_group_tags, try(each.value.tags, {}))
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if local.create_security_group && try(v.type, "ingress") == "egress" }

  # Required
  security_group_id = aws_security_group.this[0].id
  ip_protocol       = try(each.value.ip_protocol, "tcp")

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6                    = lookup(each.value, "cidr_ipv6", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  prefix_list_id               = lookup(each.value, "prefix_list_id", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  to_port                      = try(each.value.to_port, null)

  tags = merge(local.tags, var.security_group_tags, try(each.value.tags, {}))
}
