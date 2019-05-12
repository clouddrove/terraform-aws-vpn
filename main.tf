module "label" {
  source       = "github.com/clouddrove/terraform-lables"
  organization = "${var.organization}"
  name         = "${var.name}"
  environment  = "${var.environment}"
  delimiter    = "${var.delimiter}"
  attributes   = "${var.attributes}"
  tags         = "${var.tags}"
}

locals {
  preshared_key_provided                = "${length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0}"
  preshared_key_not_provided            = "${!local.preshared_key_provided}"
  internal_cidr_provided                = "${length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0}"
  internal_cidr_not_provided            = "${!local.internal_cidr_provided}"
  tunnel_details_not_specified          = "${local.internal_cidr_not_provided && local.preshared_key_not_provided}"
  tunnel_details_specified              = "${local.internal_cidr_provided && local.preshared_key_provided}"
  create_tunner_with_internal_cidr_only = "${local.internal_cidr_provided && local.preshared_key_not_provided}"
  create_tunner_with_preshared_key_only = "${local.internal_cidr_not_provided && local.preshared_key_provided }"
}

### Fully AWS managed
resource "aws_vpn_connection" "default" {
  count = "${var.create_vpn_connection && local.tunnel_details_not_specified ? 1 : 0}"

  vpn_gateway_id      = "${aws_vpn_gateway.vpn.id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"
  type                = "ipsec.1"
  static_routes_only  = "${var.vpn_connection_static_routes_only}"

  tags = "${module.label.tags}"
}

resource "aws_vpn_gateway_attachment" "default" {
  count          = "${var.create_vpn_connection && var.create_vpn_gateway_attachment ? 1 : 0}"
  vpc_id         = "${var.vpc_id}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn.id}"
}

resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count          = "${var.create_vpn_connection ? var.vpc_subnet_route_table_count : 0}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn.id}"
  route_table_id = "${element(var.vpc_subnet_route_table_ids, count.index)}"
}

resource "aws_vpn_connection_route" "default" {
  count                  = "${var.create_vpn_connection ? (var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0) : 0}"
  vpn_connection_id      = "${element(split(",", join(",", aws_vpn_connection.default.*.id)), 0)}"
  destination_cidr_block = "${element(var.vpn_connection_static_routes_destinations, count.index)}"
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = "${var.customer_ip_address}"
  type       = "ipsec.1"

  tags = "${module.label.tags}"
}

resource "aws_vpn_gateway" "vpn" {
  tags = "${module.label.tags}"
}
