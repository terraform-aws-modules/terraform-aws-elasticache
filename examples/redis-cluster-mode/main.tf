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

################################################################################
# ElastiCache Module
################################################################################

module "elasticache" {
  source = "../../"

  replication_group_id = local.name

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

  # Clustered mode
  cluster_mode_enabled       = true
  num_node_groups            = 2
  replicas_per_node_group    = 3
  automatic_failover_enabled = true
  multi_az_enabled           = true

  user_group_ids     = [module.elasticache_user_group.group_id]
  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # Security Group
  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_group_name        = local.name
  subnet_group_description = "${title(local.name)} subnet group"
  subnet_ids               = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group      = true
  parameter_group_family      = "redis7"
  parameter_group_description = "${title(local.name)} parameter group"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = local.tags
}

################################################################################
# ElastiCache Module
################################################################################

module "elasticache_user_group" {
  source = "../../modules/user-group"

  user_group_id = local.name

  default_user = {
    user_id   = "default${lower(replace(local.name, "-", ""))}"
    passwords = ["password123456789"]
  }

  users = {
    moe = {
      access_string = "on ~* +@all"
      passwords     = ["password123456789"]
    }

    larry = {
      access_string = "on ~* +@all"

      authentication_mode = {
        type = "iam"
      }
    }

    curly = {
      access_string = "on ~* +@all"

      authentication_mode = {
        type      = "password"
        passwords = ["password123456789", "password987654321"]
      }
    }
  }

  tags = local.tags
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
