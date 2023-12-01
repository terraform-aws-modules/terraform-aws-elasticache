provider "aws" {
  region = "us-west-2"
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}
