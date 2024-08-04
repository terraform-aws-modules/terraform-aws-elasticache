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
# Replication Group with Cluster Replica (single module)
################################################################################
module "replication_group_with_cluster_replica" {
  source = "../../"

  cluster_id               = "cluster"
  create_cluster           = true
  create_replication_group = true
  replication_group_id     = "repl-grp-with-cluster-replica"

  log_delivery_configuration = {
    slow-log = {
      cloudwatch_log_group_name = "repl-grp-with-cluster-replica"
      destination_type          = "cloudwatch-logs"
      log_format                = "json"
    }
  }

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

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
  subnet_group_name        = "repl-grp-with-cluster-replica"
  subnet_group_description = "repl-grp-with-cluster-replica subnet group"
  subnet_ids               = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group      = true
  parameter_group_name        = "repl-grp-with-cluster-replica"
  parameter_group_family      = "redis7"
  parameter_group_description = "repl-grp-with-cluster-replica parameter group"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = local.tags
}

################################################################################
# Add Cluster Replica to Existing Replication Group (separate modules)
################################################################################
module "replication_group" {
  source = "../../"

  replication_group_id = "ex-replication-group"

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

  transit_encryption_enabled = true
  auth_token                 = "PickSomethingMoreSecure123!"
  maintenance_window         = "sun:05:00-sun:09:00"
  apply_immediately          = true

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
  subnet_group_name        = "ex-replication-group"
  subnet_group_description = "${title(local.name)} subnet group"
  subnet_ids               = module.vpc.private_subnets

  # Parameter Group
  create_parameter_group      = true
  parameter_group_name        = "ex-replication-group"
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

module "cluster_replica" {
  source = "../../"

  cluster_id               = "ex-cluster-replica"
  create_cluster           = true
  cluster_mode_enabled     = false
  replication_group_id     = module.replication_group.replication_group_id
  create_replication_group = false
  create_subnet_group      = false

  log_delivery_configuration = {
    create_cloudwatch_log_group = false
  }
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
