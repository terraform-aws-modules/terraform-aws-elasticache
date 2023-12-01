locals {
  engine       = "memcached"
  full_version = "1.5.16"
  patch_verson = join(".", slice(split(".", local.full_version), 0, 2))
  name         = "${local.engine}-cluster-complete"
}

module "memcached_cluster" {
  source = "../../"

  cluster_id = local.name

  engine          = local.engine
  engine_version  = local.full_version
  node_type       = "cache.t2.micro"
  num_cache_nodes = 2
  az_mode         = "cross-az"

  security_group_ids = []

  # subnet group
  create_subnet_group      = true
  subnet_group_name        = "${local.name}-${replace(local.patch_verson, ".", "-")}"
  subnet_group_description = "${title(local.name)} ${local.patch_verson} subnet group"
  subnet_ids               = data.aws_subnet_ids.all.ids

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # parameter group
  create_parameter_group      = true
  parameter_group_family      = "${local.engine}${local.patch_verson}"
  parameter_group_name        = "${local.name}-${replace(local.patch_verson, ".", "-")}"
  parameter_group_description = "${title(local.name)} ${local.patch_verson} parameter group"
  parameters = [{
    name  = "idle_timeout"
    value = 60
  }]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
