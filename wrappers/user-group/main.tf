module "wrapper" {
  source = "../../modules/user-group"

  for_each = var.items

  create              = try(each.value.create, var.defaults.create, true)
  create_default_user = try(each.value.create_default_user, var.defaults.create_default_user, true)
  create_group        = try(each.value.create_group, var.defaults.create_group, true)
  default_user        = try(each.value.default_user, var.defaults.default_user, {})
  default_user_id     = try(each.value.default_user_id, var.defaults.default_user_id, "default")
  engine              = try(each.value.engine, var.defaults.engine, "redis")
  tags                = try(each.value.tags, var.defaults.tags, {})
  user_group_id       = try(each.value.user_group_id, var.defaults.user_group_id, "")
  users               = try(each.value.users, var.defaults.users, {})
}
