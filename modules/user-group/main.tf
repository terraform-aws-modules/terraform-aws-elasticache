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

  lifecycle {
    ignore_changes = [user_ids]
  }
}

################################################################################
# User(s)
################################################################################

resource "aws_elasticache_user" "this" {
  for_each = { for k, v in var.users : k => v if var.create }

  access_string = each.value.access_string

  dynamic "authentication_mode" {
    for_each = lookup(each.value, "authentication_mode", []) > 0 ? [each.value.authentication_mode] : []

    content {
      passwords = try(authentication_mode.value.passwords, [])
      type      = authentication_mode.value.type
    }
  }

  engine               = each.value.engine
  no_password_required = try(each.value.no_password_required, null)
  passwords            = try(each.value.passwords, [])
  user_id              = try(each.value.user_id, each.key)
  user_name            = try(each.value.user_name, each.key)

  tags = merge(local.tags, try(each.value.tags, {}))
}

resource "aws_elasticache_user_group_association" "this" {
  for_each = { for k, v in var.users : k => v if var.create }

  user_group_id = var.create && var.create_group ? aws_elasticache_user_group.this[0].user_group_id : each.value.user_group_id
  user_id       = aws_elasticache_user.this[each.key].user_id
}
