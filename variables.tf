#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}


variable "application" {
  type        = string
  default     = ""
  description = "Application (e.g. `cd` or `clouddrove`)."
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
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
}

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
  default     = false
  description = "Set to true for the enabled VPN connection to use static routes exclusively (only if `enable_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
}

variable "vpn_connection_static_routes_destinations" {
  type        = list(string)
  default     = []
  description = "List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`."
}

variable "tunnel1_inside_cidr" {
  type        = string
  default     = ""
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel."
}

variable "tunnel2_inside_cidr" {
  type        = string
  default     = ""
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel."
}

variable "tunnel1_preshared_key" {
  type        = string
  default     = ""
  description = "The preshared key of the first VPN tunnel."
}

variable "tunnel2_preshared_key" {
  type        = string
  default     = ""
  description = "The preshared key of the second VPN tunnel."
}

#Attachment can be already managed by the terraform-aws-vpc module by using the enable_vpn_gateway variable
variable "enable_vpn_gateway_attachment" {
  type        = bool
  default     = true
  description = "Set to false to prevent attachment of the vGW to the VPC."
}
