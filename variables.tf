#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "certificate_arn" {
  type        = string
  default     = ""
  description = "certificate_arn (e.g. '')."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "local_ipv4_network_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "remote_ipv4_network_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "label_order" {
  type        = list(any)
  default     = ["environment", "name"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
}

###########################################################################################################################################
## aws vpn
###########################################################################################################################################

variable "customer_ip_address" {
  type        = string
  description = "The IP of the Customer Gateway."
}

variable "enable_vpn_connection" {
  type        = bool
  default     = true
  description = "Set to false to prevent the creation of a VPN Connection."
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC where the VPN Gateway lives."
}

variable "vpc_subnet_route_table_ids" {
  type        = list(string)
  default     = []
  description = "The ids of the VPC subnets for which routes from the VPN Gateway will be propagated."
}

variable "vpc_subnet_route_table_count" {
  type        = string
  default     = 0
  description = "The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`."
}

variable "vpn_connection_static_routes_only" {
  type        = bool
  default     = true
  description = "Set to true for the enabled VPN connection to use static routes exclusively (only if `enable_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
}

variable "vpn_connection_static_routes_destinations" {
  type        = list(string)
  default     = []
  description = "List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`."
}

variable "virtual_private_gateway_id" {
  type        = string
  default     = null
  description = "Provide id of existing Virtual Private Gateway"
}

variable "create_virtual_private_gateway" {
  type        = bool
  default     = true
  description = "Set this to false to use existing Virtual Private Gateway(vgw) and prevent creation of vgw"
}

###########################################################################################################################################
## tunnel 1
###########################################################################################################################################



variable "tunnel1_inside_cidr" {
  type        = string
  default     = "169.254.33.88/30"
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel."
}


variable "tunnel1_preshared_key" {
  type        = string
  default     = "123456789"
  description = "The preshared key of the first VPN tunnel."
}

variable "tunnel1_phase1_encryption_algorithms" {
  type        = list(string)
  default     = null
  description = "(Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
}

variable "tunnel1_phase2_encryption_algorithms" {
  type        = list(string)
  default     = null
  description = "(Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
}

variable "tunnel1_phase1_integrity_algorithms" {
  type        = list(string)
  default     = ["SHA1"]
  description = "Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
}

variable "tunnel1_phase2_integrity_algorithms" {
  type        = list(string)
  default     = ["SHA1"]
  description = "Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
}

variable "tunnel1_phase1_dh_group_numbers" {
  type        = list(number)
  default     = null
  description = "(Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24."
}

variable "tunnel1_phase2_dh_group_numbers" {
  type        = list(number)
  default     = null
  description = "(Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24"
}

variable "tunnel1_ike_versions" {
  type        = list(string)
  default     = null
  description = "(Optional) The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 | ikev2."
}

variable "tunnel1_dpd_timeout_action" {
  type        = string
  default     = "none"
  description = "(Optional, Default clear) The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear | none | restart."
}


variable "tunnel1_startup_action" {
  type        = string
  default     = "add"
  description = "(Optional, Default clear) The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear | none | restart."
}

variable "tunnel2_inside_cidr" {
  type        = string
  default     = ""
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel."
}

variable "tunnel2_preshared_key" {
  type        = string
  default     = ""
  description = "The preshared key of the second VPN tunnel."
}

variable "tunnel2_phase1_encryption_algorithms" {
  type        = list(string)
  default     = null
  description = "(Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
}

variable "enable_vpn_gateway_attachment" {
  type        = bool
  default     = true
  description = "Set to false to prevent attachment of the vGW to the VPC."
}

variable "transit_gateway_id" {
  type        = string
  default     = null
  description = "The ID of the Transit Gateway."
}

variable "tunnel2_phase1_dh_group_numbers" {
  type        = list(number)
  default     = null
  description = "(Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24"
}

variable "tunnel1_phase1_lifetime_seconds" {
  type        = number
  default     = null
  description = "(Optional, Default 28800) The lifetime for phase 1 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 28800"
}

variable "tunnel1_dpd_timeout_seconds" {
  type        = number
  default     = null
  description = "(Optional, Default 30) The number of seconds after which a DPD timeout occurs for the first VPN tunnel. Valid value is equal or higher than 30"
}

variable "tunnel1_enable_tunnel_lifecycle_control" {
  type        = bool
  default     = null
  description = "(Optional) Turn on or off tunnel endpoint lifecycle control feature for the first VPN tunnel. Valid values are true | false"
}

variable "tunnel1_phase2_lifetime_seconds" {
  type        = number
  default     = null
  description = "(Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 3600"
}

variable "local_ipv6_network_cidr" {
  type        = string
  default     = null
  description = "(Optional) The IPv6 CIDR on the customer gateway (on-premises) side of the VPN connection."
}

variable "remote_ipv6_network_cidr" {
  type        = string
  default     = null
  description = "(Optional) The IPv6 CIDR on AWS side of the VPN connection."
}

variable "tunnel1_rekey_fuzz_percentage" {
  type        = number
  default     = null
  description = "(Optional, Default 100) The percentage of the rekey window for the first VPN tunnel (determined by tunnel1_rekey_margin_time_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100"
}

variable "tunnel1_rekey_margin_time_seconds" {
  type        = number
  default     = null
  description = "(Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the first VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel1_rekey_fuzz_percentage. Valid value is between 60 and half of tunnel1_phase2_lifetime_seconds"
}

variable "tunnel1_replay_window_size" {
  type        = number
  default     = null
  description = "(Optional, Default 1024) The number of packets in an IKE replay window for the first VPN tunnel. Valid value is between 64 and 2048."
}

variable "tunnel_inside_ip_version" {
  description = "(Optional) Indicate whether the VPN tunnels process IPv4 or IPv6 traffic. Valid values are ipv4 | ipv6. ipv6 Supports only EC2 Transit Gateway."
  type        = string
  default     = "ipv4"
}

variable "vpn_connection_type" {
  type        = string
  default     = "ipsec.1"
  description = "The type of VPN connection. The only type AWS supports at this time is 'ipsec.1'."
}

variable "bgp_asn" {
  type        = number
  default     = 65000
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
}

variable "vpn_gateway_amazon_side_asn" {
  type        = number
  default     = 64512
  description = "The Autonomous System Number (ASN) for the Amazon side of the VPN gateway. If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN"
}

variable "tunnel2_dpd_timeout_action" {
  type        = string
  default     = null
  description = "(Optional, Default clear) The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear | none | restart"
}

variable "tunnel2_enable_tunnel_lifecycle_control" {
  type        = bool
  default     = null
  description = "(Optional) Turn on or off tunnel endpoint lifecycle control feature for the second VPN tunnel. Valid values are true | false"
}

variable "tunnel2_phase2_dh_group_numbers" {
  type        = list(number)
  default     = null
  description = "(Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24"
}

variable "tunnel2_phase2_encryption_algorithms" {
  type        = list(string)
  default     = null
  description = "(Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16."
}

variable "tunnel2_phase1_integrity_algorithms" {
  type        = list(string)
  default     = ["SHA1"]
  description = "Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512."
}

variable "tunnel2_phase2_integrity_algorithms" {
  type        = list(string)
  default     = null
  description = "(Optional) List of one or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512"
}

variable "tunnel2_phase2_lifetime_seconds" {
  type        = number
  default     = null
  description = "(Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 3600"
}

variable "tunnel2_rekey_fuzz_percentage" {
  type        = number
  default     = null
  description = "(Optional, Default 100) The percentage of the rekey window for the second VPN tunnel (determined by tunnel1_rekey_margin_time_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100"
}

variable "tunnel2_rekey_margin_time_seconds" {
  type        = number
  default     = null
  description = "(Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the second VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel2_rekey_fuzz_percentage. Valid value is between 60 and half of tunnel2_phase2_lifetime_seconds"
}

variable "tunnel2_replay_window_size" {
  description = "(Optional, Default 1024) The number of packets in an IKE replay window for the second VPN tunnel. Valid value is between 64 and 2048."
  type        = number
  default     = null
}

variable "tunnel2_startup_action" {
  description = "(Optional, Default add) The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add | start"
  type        = string
  default     = null
}

variable "tunnel2_ike_versions" {
  type        = list(string)
  default     = null
  description = "(Optional) The IKE versions that are permitted for the second VPN tunnel. Valid values are ikev1 | ikev2"
}

variable "tunnel1_log_options" {
  type        = any
  default     = {}
  description = "(Optional) Options for sending VPN tunnel logs to CloudWatch."
}

variable "tunnel2_log_options" {
  type        = any
  default     = {}
  description = "(Optional) Options for sending VPN tunnel logs to CloudWatch."
}

output "vpn_connection_tunnel1_address" {
  value       = try(aws_vpn_connection.default[0].tunnel1_address)
  description = "A list with the the public IP address of the first VPN tunnel if `create_vpn_connection = true`, or empty otherwise"
}
