# NETWORK SECURITY RULE VARIABLES
variable "network_security_rule_variables" {
  type = map(object({
    network_security_rule_name                        = string                   # (Required) The name of the security rule. This needs to be unique across all Rules in the Network Security Group
    network_security_rule_resource_group_name         = string                   # (Required) The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created.
    network_security_rule_network_security_group_name = string                   # (Required) The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created
    network_security_rule_description                 = string                   # (Optional) A description for this rule. Restricted to 140 characters
    network_security_rule_protocol                    = string                   # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)
    network_security_rule_source_port_range           = string                   # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
    network_security_rule_source_port_ranges          = list(string)             # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
    network_security_rule_destination_port_range      = string                   # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
    network_security_rule_destination_port_ranges     = list(string)             # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
    network_security_rule_source_address_prefix       = string                   # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
    network_security_rule_source_address_prefixes     = list(string)             # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
    network_security_rule_source_application_security_group_names = map(object({ # (Optional) A map of source application security group names
      application_security_group_name                = string                    # (Optional) Specifies the name of the Application Security Group. Changing this forces a new resource to be created
      application_security_group_resource_group_name = string                    # (Optional) The name of the resource group in which to create the Application Security Group
    }))
    network_security_rule_destination_address_prefix   = string                       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: shell az network list-service-tags --location westcentralus. For further information please see Azure CLI - az network list-service-tags. This is required if destination_address_prefixes is not specified.
    network_security_rule_destination_address_prefixes = list(string)                 # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
    network_security_rule_destination_application_security_group_names = map(object({ # (Optional) A map of destination application security group names
      application_security_group_name                = string                         # (Optional) Specifies the name of the Application Security Group. Changing this forces a new resource to be created
      application_security_group_resource_group_name = string                         # (Optional) The name of the resource group in which to create the Application Security Group
    }))
    network_security_rule_access    = string # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
    network_security_rule_priority  = string # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
    network_security_rule_direction = string # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
  }))
  description = "Map of network security group rules"
  default     = {}
}

