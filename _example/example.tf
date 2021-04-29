provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "0.14.0"

  name       = "vpc"
  cidr_block = "172.16.0.0/16"
}

module "public_subnets" {
  source  = "clouddrove/subnet/aws"
  version = "0.14.0"

  name               = "public-subnet"
  repository         = "https://registry.terraform.io/modules/clouddrove/subnet/aws/0.14.0"
  availability_zones = ["eu-west-1b", "eu-west-1c"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}


module "vpn" {
  source              = "./../"
  name                = "vpn"
  vpc_id              = module.vpc.vpc_id
  customer_ip_address = "115.160.246.74"
}
