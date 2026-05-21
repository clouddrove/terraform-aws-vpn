## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bgp\_asn | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | `number` | `65000` | no |
| certificate\_arn | certificate\_arn (e.g. ''). | `string` | `""` | no |
| create\_virtual\_private\_gateway | Set this to false to use existing Virtual Private Gateway(vgw) and prevent creation of vgw | `bool` | `true` | no |
| customer\_ip\_address | The IP of the Customer Gateway. | `string` | n/a | yes |
| enable\_vpn\_connection | Set to false to prevent the creation of a VPN Connection. | `bool` | `true` | no |
| enable\_vpn\_gateway\_attachment | Set to false to prevent attachment of the vGW to the VPC. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "environment",<br>  "name"<br>]</pre> | no |
| local\_ipv4\_network\_cidr | n/a | `string` | `"0.0.0.0/0"` | no |
| local\_ipv6\_network\_cidr | (Optional) The IPv6 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `null` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| remote\_ipv4\_network\_cidr | n/a | `string` | `"0.0.0.0/0"` | no |
| remote\_ipv6\_network\_cidr | (Optional) The IPv6 CIDR on AWS side of the VPN connection. | `string` | `null` | no |
| transit\_gateway\_id | The ID of the Transit Gateway. | `string` | `null` | no |
| tunnel1\_dpd\_timeout\_action | (Optional, Default clear) The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"none"` | no |
| tunnel1\_dpd\_timeout\_seconds | (Optional, Default 30) The number of seconds after which a DPD timeout occurs for the first VPN tunnel. Valid value is equal or higher than 30 | `number` | `null` | no |
| tunnel1\_enable\_tunnel\_lifecycle\_control | (Optional) Turn on or off tunnel endpoint lifecycle control feature for the first VPN tunnel. Valid values are true \| false | `bool` | `null` | no |
| tunnel1\_ike\_versions | (Optional) The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2. | `list(string)` | `null` | no |
| tunnel1\_inside\_cidr | The CIDR block of the inside IP addresses for the first VPN tunnel. | `string` | `"169.254.33.88/30"` | no |
| tunnel1\_log\_options | (Optional) Options for sending VPN tunnel logs to CloudWatch. | `any` | `{}` | no |
| tunnel1\_phase1\_dh\_group\_numbers | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(number)` | `null` | no |
| tunnel1\_phase1\_encryption\_algorithms | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `null` | no |
| tunnel1\_phase1\_integrity\_algorithms | Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | <pre>[<br>  "SHA1"<br>]</pre> | no |
| tunnel1\_phase1\_lifetime\_seconds | (Optional, Default 28800) The lifetime for phase 1 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 28800 | `number` | `null` | no |
| tunnel1\_phase2\_dh\_group\_numbers | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| tunnel1\_phase2\_encryption\_algorithms | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `null` | no |
| tunnel1\_phase2\_integrity\_algorithms | Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | <pre>[<br>  "SHA1"<br>]</pre> | no |
| tunnel1\_phase2\_lifetime\_seconds | (Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 3600 | `number` | `null` | no |
| tunnel1\_preshared\_key | The preshared key of the first VPN tunnel. | `string` | `"123456789"` | no |
| tunnel1\_rekey\_fuzz\_percentage | (Optional, Default 100) The percentage of the rekey window for the first VPN tunnel (determined by tunnel1\_rekey\_margin\_time\_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100 | `number` | `null` | no |
| tunnel1\_rekey\_margin\_time\_seconds | (Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the first VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel1\_rekey\_fuzz\_percentage. Valid value is between 60 and half of tunnel1\_phase2\_lifetime\_seconds | `number` | `null` | no |
| tunnel1\_replay\_window\_size | (Optional, Default 1024) The number of packets in an IKE replay window for the first VPN tunnel. Valid value is between 64 and 2048. | `number` | `null` | no |
| tunnel1\_startup\_action | (Optional, Default clear) The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"add"` | no |
| tunnel2\_dpd\_timeout\_action | (Optional, Default clear) The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart | `string` | `null` | no |
| tunnel2\_enable\_tunnel\_lifecycle\_control | (Optional) Turn on or off tunnel endpoint lifecycle control feature for the second VPN tunnel. Valid values are true \| false | `bool` | `null` | no |
| tunnel2\_ike\_versions | (Optional) The IKE versions that are permitted for the second VPN tunnel. Valid values are ikev1 \| ikev2 | `list(string)` | `null` | no |
| tunnel2\_inside\_cidr | The CIDR block of the inside IP addresses for the second VPN tunnel. | `string` | `""` | no |
| tunnel2\_log\_options | (Optional) Options for sending VPN tunnel logs to CloudWatch. | `any` | `{}` | no |
| tunnel2\_phase1\_dh\_group\_numbers | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| tunnel2\_phase1\_encryption\_algorithms | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `null` | no |
| tunnel2\_phase1\_integrity\_algorithms | Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | <pre>[<br>  "SHA1"<br>]</pre> | no |
| tunnel2\_phase2\_dh\_group\_numbers | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 | `list(number)` | `null` | no |
| tunnel2\_phase2\_encryption\_algorithms | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `null` | no |
| tunnel2\_phase2\_integrity\_algorithms | (Optional) List of one or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 | `list(string)` | `null` | no |
| tunnel2\_phase2\_lifetime\_seconds | (Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 3600 | `number` | `null` | no |
| tunnel2\_preshared\_key | The preshared key of the second VPN tunnel. | `string` | `""` | no |
| tunnel2\_rekey\_fuzz\_percentage | (Optional, Default 100) The percentage of the rekey window for the second VPN tunnel (determined by tunnel1\_rekey\_margin\_time\_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100 | `number` | `null` | no |
| tunnel2\_rekey\_margin\_time\_seconds | (Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the second VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel2\_rekey\_fuzz\_percentage. Valid value is between 60 and half of tunnel2\_phase2\_lifetime\_seconds | `number` | `null` | no |
| tunnel2\_replay\_window\_size | (Optional, Default 1024) The number of packets in an IKE replay window for the second VPN tunnel. Valid value is between 64 and 2048. | `number` | `null` | no |
| tunnel2\_startup\_action | (Optional, Default add) The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start | `string` | `null` | no |
| tunnel\_inside\_ip\_version | (Optional) Indicate whether the VPN tunnels process IPv4 or IPv6 traffic. Valid values are ipv4 \| ipv6. ipv6 Supports only EC2 Transit Gateway. | `string` | `"ipv4"` | no |
| virtual\_private\_gateway\_id | Provide id of existing Virtual Private Gateway | `string` | `null` | no |
| vpc\_id | The id of the VPC where the VPN Gateway lives. | `string` | n/a | yes |
| vpc\_subnet\_route\_table\_count | The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`. | `string` | `0` | no |
| vpc\_subnet\_route\_table\_ids | The ids of the VPC subnets for which routes from the VPN Gateway will be propagated. | `list(string)` | `[]` | no |
| vpn\_connection\_static\_routes\_destinations | List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`. | `list(string)` | `[]` | no |
| vpn\_connection\_static\_routes\_only | Set to true for the enabled VPN connection to use static routes exclusively (only if `enable_vpn_connection = true`). Static routes must be used for devices that don't support BGP. | `bool` | `true` | no |
| vpn\_connection\_type | The type of VPN connection. The only type AWS supports at this time is 'ipsec.1'. | `string` | `"ipsec.1"` | no |
| vpn\_gateway\_amazon\_side\_asn | The Autonomous System Number (ASN) for the Amazon side of the VPN gateway. If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN | `number` | `64512` | no |

## Outputs

| Name | Description |
|------|-------------|
| customer\_gateway\_id | The ID of the VPN Connection Route. |
| gateway\_attachment\_id | The ID of the Gateway Attachment. |
| tags | A mapping of tags to assign to the resource. |
| vpn\_connection\_id | The ID of the VPN Connection. |
| vpn\_connection\_tunnel1\_address | A list with the the public IP address of the first VPN tunnel if `create_vpn_connection = true`, or empty otherwise |
| vpn\_connection\_tunnel1\_cgw\_inside\_address | A list with the the RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side) if `create_vpn_connection = true`, or empty otherwise |
| vpn\_gateway\_id | The ID of the VPN gateway. |

