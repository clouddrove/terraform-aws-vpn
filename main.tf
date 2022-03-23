# Managed By : CloudDrove
# Description : This Script is used to create VPN, CUSTOMER GATEWAY, and VPN GATEWAY.
# Copyright @ CloudDrove. All Right Reserved.


#Module      : labels
#Description : This terraform module is designed to generate consistent labels names and
#              tags for resources. You can use terraform-labels to implement a strict
#              naming convention.
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "0.15.0"

  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  enabled     = var.enable_vpn_connection
}

locals {
  preshared_key_provided                = length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0
  preshared_key_not_provided            = false == local.preshared_key_provided
  internal_cidr_provided                = length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0
  internal_cidr_not_provided            = false == local.internal_cidr_provided
  tunnel_details_not_specified          = local.internal_cidr_not_provided && local.preshared_key_not_provided
  tunnel_details_specified              = local.internal_cidr_provided && local.preshared_key_provided
  enable_tunner_with_internal_cidr_only = local.internal_cidr_provided && local.preshared_key_not_provided
  enable_tunner_with_preshared_key_only = local.internal_cidr_not_provided && local.preshared_key_provided
}

#Module       VPN Connection
#Description: Manages an EC2 VPN connection. These objects can be connected to customer gateways,
#             and allow you to establish tunnels between your network and Amazon
resource "aws_vpn_connection" "default" {
  count = var.enable_vpn_connection && local.tunnel_details_not_specified ? 1 : 0

  vpn_gateway_id           = join("", aws_vpn_gateway.vpn.*.id)
  customer_gateway_id      = join("", aws_customer_gateway.main.*.id)
  type                     = "ipsec.1"
  static_routes_only       = var.vpn_connection_static_routes_only
  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr
  tags                     = module.labels.tags
}

#Module       Gateway Attachment
#Description: Provides a Virtual Private Gateway attachment resource,
#             allowing for an existing hardware VPN gateway to be attached and/or detached from a VPC.
resource "aws_vpn_gateway_attachment" "default" {
  count          = var.enable_vpn_connection && var.enable_vpn_gateway_attachment ? 1 : 0
  vpc_id         = var.vpc_id
  vpn_gateway_id = join("", aws_vpn_gateway.vpn.*.id)
}

#Module       Gateway Route Propagation
#Description: Requests automatic route propagation between a VPN gateway and a route table.
resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count          = var.enable_vpn_connection ? var.vpc_subnet_route_table_count : 0
  vpn_gateway_id = join("", aws_vpn_gateway.vpn.*.id)
  route_table_id = element(var.vpc_subnet_route_table_ids, count.index)
}

#Module       Connection Route
#Description: Provides a static route between a VPN connection and a customer gateway.
resource "aws_vpn_connection_route" "default" {
  count                  = var.enable_vpn_connection ? var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0 : 0
  vpn_connection_id      = element(split("", join("", aws_vpn_connection.default.*.id)), 0)
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}

#Module       Aws Customer Gateway
#Description: Provides a customer gateway inside a VPC
resource "aws_customer_gateway" "main" {
  count           = var.enable_vpn_connection && var.enable_vpn_gateway_attachment ? 1 : 0
  bgp_asn         = 65000
  ip_address      = var.customer_ip_address
  type            = "ipsec.1"
  certificate_arn = var.certificate_arn
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s-cgw", module.labels.id)
    }
  )
}

#Module       AWS VPN Gateway
#Description: Provides a resource to enable a VPC VPN Gateway.
resource "aws_vpn_gateway" "vpn" {
  count = var.enable_vpn_connection && var.enable_vpn_gateway_attachment ? 1 : 0
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s-vgw", module.labels.id)
    }
  )
}
