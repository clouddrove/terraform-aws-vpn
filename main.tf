##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
}

locals {
  preshared_key_provided       = length(var.tunnel1_preshared_key) > 0 && length(var.tunnel2_preshared_key) > 0
  preshared_key_not_provided   = false == local.preshared_key_provided
  internal_cidr_provided       = length(var.tunnel1_inside_cidr) > 0 && length(var.tunnel2_inside_cidr) > 0
  internal_cidr_not_provided   = false == local.internal_cidr_provided
  tunnel_details_not_specified = local.internal_cidr_not_provided && local.preshared_key_not_provided
}

##-----------------------------------------------------------------------------
## aws_vpn_connection. Manages a Site-to-Site VPN connection.
##-----------------------------------------------------------------------------
resource "aws_vpn_connection" "default" {
  count = var.enable_vpn_connection && local.tunnel_details_not_specified ? 1 : 0

  vpn_gateway_id                          = join("", aws_vpn_gateway.vpn[*].id)
  customer_gateway_id                     = join("", aws_customer_gateway.main[*].id)
  transit_gateway_id                      = var.transit_gateway_id
  type                                    = var.vpn_connection_type
  static_routes_only                      = var.vpn_connection_static_routes_only
  local_ipv4_network_cidr                 = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr                = var.remote_ipv4_network_cidr
  local_ipv6_network_cidr                 = var.local_ipv6_network_cidr
  remote_ipv6_network_cidr                = var.remote_ipv6_network_cidr
  tunnel1_dpd_timeout_action              = var.tunnel1_dpd_timeout_action
  tunnel1_preshared_key                   = var.tunnel1_preshared_key
  tunnel1_startup_action                  = var.tunnel1_startup_action
  tunnel1_phase1_encryption_algorithms    = var.tunnel1_phase1_encryption_algorithms
  tunnel1_phase2_encryption_algorithms    = var.tunnel1_phase2_encryption_algorithms
  tunnel1_phase1_integrity_algorithms     = var.tunnel1_phase1_integrity_algorithms
  tunnel1_phase2_integrity_algorithms     = var.tunnel1_phase2_integrity_algorithms
  tunnel1_phase1_dh_group_numbers         = var.tunnel1_phase1_dh_group_numbers
  tunnel1_phase2_dh_group_numbers         = var.tunnel1_phase2_dh_group_numbers
  tunnel1_phase1_lifetime_seconds         = var.tunnel1_phase1_lifetime_seconds
  tunnel1_ike_versions                    = var.tunnel1_ike_versions
  tunnel1_inside_cidr                     = var.tunnel1_inside_cidr
  tunnel1_dpd_timeout_seconds             = var.tunnel1_dpd_timeout_seconds
  tunnel1_enable_tunnel_lifecycle_control = var.tunnel1_enable_tunnel_lifecycle_control
  tunnel1_phase2_lifetime_seconds         = var.tunnel1_phase2_lifetime_seconds
  tunnel1_rekey_fuzz_percentage           = var.tunnel1_rekey_fuzz_percentage
  tunnel1_rekey_margin_time_seconds       = var.tunnel1_rekey_margin_time_seconds
  tunnel1_replay_window_size              = var.tunnel1_replay_window_size
  tunnel_inside_ip_version                = var.tunnel_inside_ip_version

  tunnel2_dpd_timeout_action              = var.tunnel2_dpd_timeout_action
  tunnel2_enable_tunnel_lifecycle_control = var.tunnel2_enable_tunnel_lifecycle_control
  tunnel2_phase2_dh_group_numbers         = var.tunnel2_phase2_dh_group_numbers
  tunnel2_phase2_encryption_algorithms    = var.tunnel2_phase2_encryption_algorithms
  tunnel2_phase2_integrity_algorithms     = var.tunnel2_phase2_integrity_algorithms
  tunnel2_phase2_lifetime_seconds         = var.tunnel2_phase2_lifetime_seconds
  tunnel2_rekey_fuzz_percentage           = var.tunnel2_rekey_fuzz_percentage
  tunnel2_rekey_margin_time_seconds       = var.tunnel2_rekey_margin_time_seconds
  tunnel2_replay_window_size              = var.tunnel2_replay_window_size
  tunnel2_startup_action                  = var.tunnel2_startup_action
  tunnel2_ike_versions                    = var.tunnel2_ike_versions
  tunnel2_phase1_dh_group_numbers         = var.tunnel2_phase1_dh_group_numbers

  dynamic "tunnel1_log_options" {
    for_each = [var.tunnel1_log_options]

    content {
      dynamic "cloudwatch_log_options" {
        for_each = tunnel1_log_options.value

        content {
          log_enabled       = lookup(cloudwatch_log_options.value, "log_enabled", null)
          log_group_arn     = lookup(cloudwatch_log_options.value, "log_group_arn", null)
          log_output_format = lookup(cloudwatch_log_options.value, "log_output_format", null)
        }
      }
    }
  }

  dynamic "tunnel2_log_options" {
    for_each = [var.tunnel2_log_options]

    content {
      dynamic "cloudwatch_log_options" {
        for_each = tunnel2_log_options.value

        content {
          log_enabled       = lookup(cloudwatch_log_options.value, "log_enabled", null)
          log_group_arn     = lookup(cloudwatch_log_options.value, "log_group_arn", null)
          log_output_format = lookup(cloudwatch_log_options.value, "log_output_format", null)
        }
      }
    }
  }

  tags = module.labels.tags
}

##-----------------------------------------------------------------------------
## Provides a Virtual Private Gateway attachment resource, allowing for an existing hardware VPN gateway to be attached and/or detached from a VPC
##-----------------------------------------------------------------------------
resource "aws_vpn_gateway_attachment" "default" {
  count          = var.enable_vpn_connection && var.enable_vpn_gateway_attachment ? 1 : 0
  vpc_id         = var.vpc_id
  vpn_gateway_id = join("", aws_vpn_gateway.vpn[*].id)
}

##-----------------------------------------------------------------------------
## Requests automatic route propagation between a VPN gateway and a route table.
##-----------------------------------------------------------------------------
resource "aws_vpn_gateway_route_propagation" "private_subnets_vpn_routing" {
  count          = var.enable_vpn_connection ? var.vpc_subnet_route_table_count : 0
  vpn_gateway_id = join("", aws_vpn_gateway.vpn[*].id)
  route_table_id = element(var.vpc_subnet_route_table_ids, count.index)
}

##-----------------------------------------------------------------------------
## Provides a static route between a VPN connection and a customer gateway.
##-----------------------------------------------------------------------------
resource "aws_vpn_connection_route" "default" {
  count                  = var.enable_vpn_connection ? var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0 : 0
  vpn_connection_id      = join("", aws_vpn_connection.default[*].id)
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}

##-----------------------------------------------------------------------------
## Provides a customer gateway inside a VPC. These objects can be connected to VPN gateways via VPN connections, and allow you to establish tunnels between your network and the VPC.
##-----------------------------------------------------------------------------
resource "aws_customer_gateway" "main" {
  count           = var.enable_vpn_connection && var.enable_vpn_gateway_attachment ? 1 : 0
  bgp_asn         = var.bgp_asn
  ip_address      = var.customer_ip_address
  type            = var.vpn_connection_type
  certificate_arn = var.certificate_arn
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s-cgw", module.labels.id)
    }
  )
}

##-----------------------------------------------------------------------------
## VPN gateways provide secure connectivity between multiple sites, such as on-premises data centers, Google Cloud Virtual Private Cloud (VPC) networks, and Google Cloud VMware Engine private clouds.
##-----------------------------------------------------------------------------
resource "aws_vpn_gateway" "vpn" {
  count           = var.enable_vpn_connection && var.enable_vpn_gateway_attachment ? 1 : 0
  vpc_id          = var.vpc_id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn

  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s-vgw", module.labels.id)
    }
  )
}
