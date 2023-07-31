##----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
##----------------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}

##-----------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "2.0.0"
  name        = "vpc"
  environment = "Dev"
  label_order = ["name", "environment"]

  cidr_block = "172.16.0.0/16"
}

##-----------------------------------------------------
## A subnet is a range of IP addresses in your VPC.
##-----------------------------------------------------
module "public_subnets" {
  source  = "clouddrove/subnet/aws"
  version = "1.3.0"

  name        = "public-subnet"
  environment = "Dev"
  label_order = ["environment", "name"]

  availability_zones = ["eu-west-1b", "eu-west-1c"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

##-----------------------------------------------------------------------------
## vpn module call.
##-----------------------------------------------------------------------------
module "vpn" {
  source = "./../"

  name        = "vpn"
  environment = "Dev"
  label_order = ["environment", "name"]

  vpc_id                   = module.vpc.vpc_id
  customer_ip_address      = "115.160.246.74"
  local_ipv4_network_cidr  = "0.0.0.0/0"
  remote_ipv4_network_cidr = "0.0.0.0/0"
}
