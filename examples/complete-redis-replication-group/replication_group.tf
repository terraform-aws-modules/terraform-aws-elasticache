locals {
  engine       = "redis"
  full_version = "5.0.6"
  patch_verson = join(".", slice(split(".", local.full_version), 0, 2))
  name         = "${local.engine}-repl-group-complete"
}

module "redis_repl_group" {
  source = "../../"

  create_replication_group = true
  replication_group_id     = local.name

  engine         = local.engine
  engine_version = local.full_version
  node_type      = "cache.t2.micro"

  # cluster_mode = [{
  #   replicas_per_node_group = 1
  #   num_node_groups         = 3
  # }]

  # snapshot_retention_limit = 1
  # snapshot_window          = "20:00-23:00"

  transit_encryption_enabled = true
  auth_token                 = "PickSomethingMoreSecure123!"

  security_group_ids = []

  # subnet group
  subnet_group_name        = "${local.name}-${replace(local.patch_verson, ".", "-")}"
  subnet_group_description = "${title(local.name)} ${local.patch_verson} subnet group"
  subnet_ids               = data.aws_subnet_ids.all.ids

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # parameter group
  create_parameter_group = false
  parameter_group_name   = "default.${local.engine}${local.patch_verson}"

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
