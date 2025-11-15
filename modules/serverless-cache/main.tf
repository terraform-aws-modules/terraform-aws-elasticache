################################################################################
# Serverless Cache
################################################################################

resource "aws_elasticache_serverless_cache" "this" {
  count = var.create ? 1 : 0

  region = var.region

  engine = var.engine
  name   = var.cache_name

  dynamic "cache_usage_limits" {
    for_each = var.cache_usage_limits != null ? [var.cache_usage_limits] : []

    content {
      dynamic "data_storage" {
        for_each = cache_usage_limits.value.data_storage != null ? [cache_usage_limits.value.data_storage] : []

        content {
          maximum = data_storage.value.maximum
          minimum = data_storage.value.minimum
          unit    = data_storage.value.unit
        }
      }

      dynamic "ecpu_per_second" {
        for_each = cache_usage_limits.value.ecpu_per_second != null ? [cache_usage_limits.value.ecpu_per_second] : []

        content {
          maximum = ecpu_per_second.value.maximum
          minimum = ecpu_per_second.value.minimum
        }
      }
    }
  }
  daily_snapshot_time      = var.daily_snapshot_time
  description              = var.description
  kms_key_id               = var.kms_key_id
  major_engine_version     = var.major_engine_version
  security_group_ids       = var.security_group_ids
  snapshot_arns_to_restore = var.snapshot_arns_to_restore
  snapshot_retention_limit = var.snapshot_retention_limit
  subnet_ids               = var.subnet_ids
  user_group_id            = var.user_group_id

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  tags = var.tags
}
