module "vpn" {
  source              = "./../../terraform-aws-vpn"
  name                = "vpn"
  application        = "Clouddrove"
  environment         = "test"
  createdby           = "Anmol"
  vpc_id              = "vpc-XXXXXXXXX"
  customer_ip_address = "0.0.0.0"
}
