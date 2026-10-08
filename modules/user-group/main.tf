locals {
  tags = merge(var.tags, { terraform-aws-modules = "elasticache" })
}

################################################################################
# Group
################################################################################

resource "aws_elasticache_user_group" "this" {
  count = var.create && var.create_group ? 1 : 0

  engine        = var.engine
  user_group_id = var.user_group_id
  tags          = local.tags
  user_ids      = var.create_default_user ? [aws_elasticache_user.default[0].user_id] : [var.default_user_id]

  lifecycle {
    ignore_changes = [user_ids]
  }
}

resource "aws_elasticache_user" "default" {
  count = var.create && var.create_default_user ? 1 : 0

  access_string = try(var.default_user.access_string, "on ~* +@read")

  dynamic "authentication_mode" {
    for_each = try([var.default_user.authentication_mode], [])

    content {
      passwords = try(authentication_mode.value.passwords, null)
      type      = authentication_mode.value.type
    }
  }

  engine               = try(var.default_user.engine, "redis")
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

  access_string = each.value.access_string

  dynamic "authentication_mode" {
    for_each = try([each.value.authentication_mode], [])

    content {
      passwords = try(authentication_mode.value.passwords, null)
      type      = authentication_mode.value.type
    }
  }

  engine               = try(each.value.engine, "redis")
  no_password_required = try(each.value.no_password_required, null)
  passwords            = try(each.value.passwords, null)
  user_id              = try(each.value.user_id, each.key)
  user_name            = try(each.value.user_name, each.key)

  tags = merge(local.tags, try(each.value.tags, {}))
}

resource "aws_elasticache_user_group_association" "this" {
  for_each = { for k, v in var.users : k => v if var.create }

  user_group_id = var.create && var.create_group ? aws_elasticache_user_group.this[0].user_group_id : each.value.user_group_id
  user_id       = aws_elasticache_user.this[each.key].user_id

  dynamic "timeouts" {
    for_each = try([each.value.timeouts], [])
    content {
      create = try(timeouts.value.create, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
