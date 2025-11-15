module "wrapper" {
  source = "../../modules/serverless-cache"

  for_each = var.items

  cache_name               = try(each.value.cache_name, var.defaults.cache_name, null)
  cache_usage_limits       = try(each.value.cache_usage_limits, var.defaults.cache_usage_limits, null)
  create                   = try(each.value.create, var.defaults.create, true)
  daily_snapshot_time      = try(each.value.daily_snapshot_time, var.defaults.daily_snapshot_time, null)
  description              = try(each.value.description, var.defaults.description, "Serverless Cache")
  engine                   = try(each.value.engine, var.defaults.engine, "redis")
  kms_key_id               = try(each.value.kms_key_id, var.defaults.kms_key_id, null)
  major_engine_version     = try(each.value.major_engine_version, var.defaults.major_engine_version, null)
  region                   = try(each.value.region, var.defaults.region, null)
  security_group_ids       = try(each.value.security_group_ids, var.defaults.security_group_ids, [])
  snapshot_arns_to_restore = try(each.value.snapshot_arns_to_restore, var.defaults.snapshot_arns_to_restore, null)
  snapshot_retention_limit = try(each.value.snapshot_retention_limit, var.defaults.snapshot_retention_limit, null)
  subnet_ids               = try(each.value.subnet_ids, var.defaults.subnet_ids, [])
  tags                     = try(each.value.tags, var.defaults.tags, {})
  timeouts                 = try(each.value.timeouts, var.defaults.timeouts, null)
  user_group_id            = try(each.value.user_group_id, var.defaults.user_group_id, null)
}
