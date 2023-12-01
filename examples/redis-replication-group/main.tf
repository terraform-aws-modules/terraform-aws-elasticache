provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/clowdhaus/terraform-aws-elasticache"
  }
}

################################################################################
# ElastiCache Module
################################################################################

module "elasticache" {
  source = "../../"

  create_replication_group = true
  replication_group_id     = local.name

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

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
  subnet_group_name        = local.name
  subnet_group_description = "${title(local.name)} subnet group"
  subnet_ids               = module.vpc.private_subnets

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  # parameter group
  create_parameter_group      = true
  parameter_group_name        = local.name
  parameter_group_family      = "redis7.1"
  parameter_group_description = "${title(local.name)} parameter group"
  parameters = [
    {
      name  = "activerehashing"
      value = "yes"
    },
    {
      name  = "min-slaves-to-write"
      value = "2"
    }
  ]

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
