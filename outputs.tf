#Module      : VPN
# Description : This Script is used to create VPN, CUSTOMER GATEWAY, and VPN GATEWAY.

output "vpn_connection_id" {
  value = concat(
    aws_vpn_connection.default.*.id
  )[0]
  description = "The ID of the VPN Connection."
}

output "gateway_attachment_id" {
  value = concat(
    aws_vpn_gateway_attachment.default.*.id
  )[0]
  description = "The ID of the Gateway Attachment."
}

output "customer_gateway_id" {
  value = concat(
    aws_customer_gateway.main.*.id
  )[0]
  description = "The ID of the VPN Connection Route."
}

output "vpn_gateway_id" {
  value = concat(
    aws_vpn_gateway.vpn.*.id
  )[0]
  description = "The ID of the VPN gateway."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}
