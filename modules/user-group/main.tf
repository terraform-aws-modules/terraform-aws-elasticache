locals {
  tags = merge(var.tags, { terraform-aws-modules = "elasticache" })
}

################################################################################
# Group
################################################################################

resource "aws_elasticache_user_group" "this" {
  count = var.create && var.create_group ? 1 : 0

  region = var.region

  engine        = var.engine
  user_group_id = var.user_group_id
  user_ids      = var.create_default_user ? concat(aws_elasticache_user.default[*].user_id, var.user_ids) : var.user_ids
  tags          = local.tags

  lifecycle {
    ignore_changes = [user_ids]
  }
}

################################################################################
# User - Default
################################################################################

resource "aws_elasticache_user" "default" {
  count = var.create && var.create_default_user ? 1 : 0

  region = var.region

  access_string = try(var.default_user.access_string, "on ~* +@read")

  dynamic "authentication_mode" {
    for_each = try([var.default_user.authentication_mode], [])

    content {
      passwords = try(authentication_mode.value.passwords, null)
      type      = authentication_mode.value.type
    }
  }

  engine               = try(var.default_user.engine, "REDIS")
  no_password_required = try(var.default_user.no_password_required, null)
  passwords            = try(var.default_user.passwords, null)
  user_id              = var.default_user.user_id
  user_name            = "default"

  tags = local.tags
}

################################################################################
# User(s)
################################################################################

resource "aws_elasticache_user" "this" {
  for_each = { for k, v in var.users : k => v if var.create }

  region = var.region

  access_string = each.value.access_string

  dynamic "authentication_mode" {
    for_each = try([each.value.authentication_mode], [])

    content {
      passwords = try(authentication_mode.value.passwords, null)
      type      = authentication_mode.value.type
    }
  }

  engine               = try(each.value.engine, "REDIS")
  no_password_required = try(each.value.no_password_required, null)
  passwords            = try(each.value.passwords, null)
  user_id              = try(each.value.user_id, each.key)
  user_name            = try(each.value.user_name, each.key)

  tags = merge(local.tags, try(each.value.tags, {}))
}

resource "aws_elasticache_user_group_association" "this" {
  for_each = { for k, v in var.users : k => v if var.create }

  region = var.region

  user_group_id = var.create && var.create_group ? aws_elasticache_user_group.this[0].user_group_id : each.value.user_group_id
  user_id       = aws_elasticache_user.this[each.key].user_id

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}
