locals {
  description = coalesce(var.description, "ElastiCache subnet group for ${lower(var.identifier)}")
}

resource "aws_elasticache_subnet_group" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  description = local.description
  subnet_ids  = var.subnet_ids
}
