resource "aws_elasticache_serverless_cache" "this" {
  count = var.create ? 1 : 0

  engine = var.engine
  name   = var.cache_name

  dynamic "cache_usage_limits" {
    for_each = length(var.cache_usage_limits) > 0 ? [var.cache_usage_limits] : []
    content {

      dynamic "data_storage" {
        for_each = try([cache_usage_limits.value.data_storage], [])
        content {
          maximum = try(data_storage.value.maximum, null)
          minimum = try(data_storage.value.minimum, null)
          unit    = try(data_storage.value.unit, "GB")
        }
      }

      dynamic "ecpu_per_second" {
        for_each = try([cache_usage_limits.value.ecpu_per_second], [])
        content {
          maximum = try(ecpu_per_second.value.maximum, null)
          minimum = try(ecpu_per_second.value.minimum, null)
        }
      }
    }
  }
  daily_snapshot_time      = var.daily_snapshot_time
  description              = coalesce(var.description, "Serverless Cache")
  kms_key_id               = var.kms_key_id
  major_engine_version     = var.major_engine_version
  security_group_ids       = var.security_group_ids
  snapshot_arns_to_restore = var.snapshot_arns_to_restore
  snapshot_retention_limit = var.snapshot_retention_limit
  subnet_ids               = var.subnet_ids
  user_group_id            = var.user_group_id

  timeouts {
    create = try(var.timeouts.create, "40m")
    delete = try(var.timeouts.delete, "80m")
    update = try(var.timeouts.update, "40m")
  }

  tags = var.tags
}
