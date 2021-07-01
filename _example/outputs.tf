output "id" {
  value       = module.vpn.vpn_gateway_id
  description = "The ID of the VPN gateway."
}

output "tags" {
  value       = module.vpn.tags
  description = "A mapping of tags to assign to the resource."
}
