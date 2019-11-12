provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "git::https://github.com/clouddrove/terraform-aws-vpc.git"

  name        = "vpc"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "application", "name"]

  cidr_block = "172.16.0.0/16"
}

module "public_subnets" {
  source = "git::https://github.com/clouddrove/terraform-aws-subnet.git"

  name        = "public-subnet"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "application", "name"]

  availability_zones = ["eu-west-1b", "eu-west-1c"]
  vpc_id             = module.vpc.vpc_id
  cidr_block         = module.vpc.vpc_cidr_block
  type               = "public"
  igw_id             = module.vpc.igw_id
}


module "vpn" {
  source              = "git::https://github.com/clouddrove/terraform-aws-vpn.git?ref=tags/0.12.0"
  name                = "vpn"
  application         = "clouddrove"
  environment         = "test"
  label_order         = ["environment", "application", "name"]
  vpc_id              = module.vpc.vpc_id
  customer_ip_address = "115.160.246.74"
}
