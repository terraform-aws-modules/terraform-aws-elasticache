provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "eu-west-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-elasticache"
  }
}

module "serverless" {
  source = "../../modules/serverless-cache"

  engine     = "redis"
  cache_name = local.name

  cache_usage_limits = {
    data_storage = {
      maximum = 2
    }
    ecpu_per_second = {
      maximum = 1000
    }
  }

  daily_snapshot_time  = "22:00"
  description          = "${local.name} serverless cluster"
  kms_key_id           = aws_kms_key.this.arn
  major_engine_version = "7"
  security_group_ids   = [module.sg.security_group_id]

  snapshot_retention_limit = 7
  subnet_ids               = module.vpc.private_subnets

  user_group_id = module.cache_user_group.group_id
}

module "valkey_serverless" {
  source = "../../modules/serverless-cache"

  engine     = "valkey"
  cache_name = "${local.name}-valkey"

  cache_usage_limits = {
    data_storage = {
      maximum = 2
    }
    ecpu_per_second = {
      maximum = 1000
    }
  }

  daily_snapshot_time  = "22:00"
  description          = "${local.name} valkey serverless cluster"
  kms_key_id           = aws_kms_key.this.arn
  major_engine_version = "7"
  security_group_ids   = [module.sg.security_group_id]

  snapshot_retention_limit = 7
  subnet_ids               = module.vpc.private_subnets

  user_group_id = module.cache_user_group.group_id
}

module "cache_user_group" {
  source = "../../modules/user-group"

  default_user = {
    user_id = "${local.name}-default"
    authentication_mode = {
      type = "no-password-required"
    }
  }

  users = {
    redis = {
      user_id       = local.name
      user_name     = "redis"
      access_string = "on ~* -@all +@read"
      authentication_mode = {
        type = "no-password-required"
      }
      timeouts = {
        create = "20m"
      }
    }
  }

  user_group_id = "redis"
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  tags = local.tags
}

resource "aws_kms_key" "this" {
  description         = "KMS CMK for ${local.name}"
  enable_key_rotation = true

  tags = local.tags
}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Security group for VPC traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["redis-tcp"]

  tags = local.tags
}
