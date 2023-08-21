output "id" {
  value       = module.vpn.vpn_gateway_id
  description = "The ID of the VPN gateway."
}

output "tags" {
  value       = module.vpn.tags
  description = "A mapping of tags to assign to the resource."
}

output "vpn_connection_id" {
  value       = module.vpn.vpn_connection_id
  description = "VPN connection id"
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  value       = module.vpn.vpn_connection_tunnel1_cgw_inside_address
  description = "Tunnel1 CGW address"
}

output "vpn_connection_tunnel1_address" {
  value       = module.vpn.vpn_connection_tunnel1_address
  description = "Tunnel1 address"
}
