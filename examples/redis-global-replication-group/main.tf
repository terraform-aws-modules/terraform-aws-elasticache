provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "euwest1"
  region = "eu-west-1"
}

data "aws_availability_zones" "primary" {}
data "aws_availability_zones" "secondary" {
  provider = aws.euwest1
}

locals {
  name = "ex-${basename(path.cwd)}"

  vpc_cidr      = "10.0.0.0/16"
  primary_azs   = slice(data.aws_availability_zones.primary.names, 0, 3)
  secondary_azs = slice(data.aws_availability_zones.secondary.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-elasticache"
  }
}

################################################################################
# ElastiCache Module
################################################################################

module "elasticache_primary" {
  source = "../../"

  replication_group_id                    = local.name
  create_primary_global_replication_group = true

  engine_version = "7.1"
  node_type      = "cache.r7g.large"

  # Security Group
  vpc_id = module.vpc_primary.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc_primary.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc_primary.private_subnets

  tags = local.tags
}

module "elasticache_secondary" {
  source = "../../"

  providers = {
    aws = aws.euwest1
  }

  replication_group_id                      = local.name
  create_secondary_global_replication_group = true
  global_replication_group_id               = module.elasticache_primary.global_replication_group_id

  # Security Group
  vpc_id = module.vpc_secondary.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "VPC traffic"
      cidr_ipv4   = module.vpc_secondary.vpc_cidr_block
    }
  }

  # Subnet Group
  subnet_ids = module.vpc_secondary.private_subnets

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc_primary" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.primary_azs
  public_subnets  = [for k, v in local.primary_azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.primary_azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  tags = local.tags
}

module "vpc_secondary" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  providers = {
    aws = aws.euwest1
  }

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.secondary_azs
  public_subnets  = [for k, v in local.secondary_azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.secondary_azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  tags = local.tags
}
