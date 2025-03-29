# NETWORK SECURITY GROUP VARIABLES
variable "network_security_group_variables" {
  type = map(object({
    network_security_group_name                = string                                     # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = string                                     # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = string                                     # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = optional(map(object({                            # (Optional) List of objects representing security rules
      security_rule_name                                           = string                 # (Required) The name of the security rule
      security_rule_application_security_group_resource_group_name = optional(string)       # (Optional) The resource group name of the application security group
      security_rule_description                                    = optional(string)       # (Optional) A description for this rule. Restricted to 140 characters 
      security_rule_protocol                                       = string                 # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
      security_rule_source_port_range                              = optional(string)       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
      security_rule_source_port_ranges                             = optional(list(string)) # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
      security_rule_destination_port_range                         = optional(string)       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
      security_rule_destination_port_ranges                        = optional(list(string)) # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
      security_rule_source_address_prefix                          = optional(string)       # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified
      security_rule_source_address_prefixes                        = optional(list(string)) # (Optional) Tags may not be used. This is required if source_address_prefix is not specified.
      security_rule_source_application_security_group_names = optional(map(object({
        application_security_group_name                = optional(string) #(Optional) Application Security Group Name
        application_security_group_resource_group_name = optional(string) #(Optional) Application Security Group ResourceGroup Name
      })))                                                                # (Optional) A list of source application security group ids
      security_rule_destination_address_prefix   = optional(string)       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
      security_rule_destination_address_prefixes = optional(list(string)) # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified
      security_rule_destination_application_security_group_names = optional(map(object({
        application_security_group_name                = string #(Optional) Application Security Group Name
        application_security_group_resource_group_name = string #(Optional) Application Security Group ResourceGroup Name
      })))                                                      # (Optional) A list of destination application security group ids
      security_rule_access    = string                          # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
      security_rule_priority  = string                          # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
      security_rule_direction = string                          # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
    })))
    network_security_group_tags = optional(map(string)) #(Optional) A mapping of tags which should be assigned to the Network Security Group.
  }))
  description = "Map of object for network security group details"
  default     = {}
}

variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}