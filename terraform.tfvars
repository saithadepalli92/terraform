# #RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "dev-rg" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "terraform"         #(optional) The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Owner      = "saithadepalli",
      Department = "CIS"
    }
  }
}

#NETWORK SECURITY GROUP WITH REQUIRED ATTRIBUTES
network_security_group_variables = {
  "network_security_group_1" = {
    network_security_group_name                = "dev-nsg1" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "dev-rg"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "eastus"          # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {
      "nsg_rule_01" = {
        security_rule_name                       = "winrdp" # (Required) The name of the security rule
        security_rule_priority                   = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                  = "Inbound"              # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                     = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                   = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range          = "3389"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_destination_port_range     = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_source_address_prefix      = "*"                    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_destination_address_prefix = "*"                    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_description                = "WinRDPAllow"      # (Optional) A description for this rule. Restricted to 140 characters
      },
      "nsg_rule_02" = {
        security_rule_name                                           = "TCP" # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null                   # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Outbound"             # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null                   # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null                   # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"                    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null                   # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"                    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null                   # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "OutboundAllow100"     # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null                   # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null                   # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { # (Optional) A mapping of tags which should be assigned to the Network Security Group.
      Owner      = "saithadepalli",
      Department = "CIS"
    }
  }
}


#DDOS plan creation is optional and costly. Uncommenting  will create a new DDOS protection plan. Use only if required. 
/*network_ddos_protection_plan_variables = {
  "ddos_plan_1" = {
    network_ddos_protection_plan_name                = "XXXXX" #(Required) Specifies the name of the Network DDoS Protection Plan. 
    network_ddos_protection_plan_location            = "eastus"                #(Required) The name of the resource group in which to create the resource.
    network_ddos_protection_plan_resource_group_name = "XXXXX"       #(Required) Specifies the supported Azure location where the resource exists.
    #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
    network_ddos_protection_plan_tags = {
      Owner      = "xxxxxxx@XXXX.com",
      Department = "CIS"
    }
  }
}*/

# ROUTE TABLE Optional
# route_table_variables = {
#   "route_table_1" = {
#     route_table_name                          = "XXX" #(Required) The name of the route table. 
#     route_table_location                      = "eastus"         #(Required) The Azure location where the resource should exist.
#     route_table_resource_group_name           = "XXXXX" #(Required) The name of the resource group in which to create the route table.
#     route_table_bgp_route_propagation_enabled = true              #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. Defaults to true.
#     route_table_tags = {                                          #(Optional) A mapping of tags to assign to the resource.
#       Owner      = "xxxxxxx@XXXXX.com",
#       Department = "CIS"
#     }
#     route_table_route = [{                                #(Optional) List of objects representing routes.
#       route_name                   = "XXXXXX" #(Required) The name of the route.
#       route_address_prefix         = "10.3.0.0/16"        #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
#       route_next_hop_type          = "None"               #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
#       route_next_hop_in_ip_address = "10.2.0.0/24"        #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
#       },
#       {
#         route_name                   = "XXXXXX" #(Required) The name of the route.
#         route_address_prefix         = "10.2.0.0/16"        #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
#         route_next_hop_type          = "None"               #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
#         route_next_hop_in_ip_address = "10.2.1.0/24"        #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
#       },
#     ]
#   }
# }

#VIRTUAL NETWORK 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "dev-vnet01"         #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"                   #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "dev-rg"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = ["10.1.0.0"]                #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = 5                           #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    #virtual_network_bgp_community           = "12076:5060"                #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    #virtual_network_edge_zone               = "eastus2-az1"               #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    # virtual_network_ddos_protection_plan = {                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
    #   virtual_network_ddos_protection_enable    = true                    #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
    #   virtual_network_ddos_protection_plan_name = "XXXXXX" #(Required) for the ID of DDoS Protection Plan.
    # }
    virtual_network_encryption = [
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted"
      }
    ]
    virtual_network_subnet = [ #(Optional) Can be specified multiple times to define multiple subnets
      {
        virtual_network_subnet_name                                       = "dev-subnet01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = ["10.0.0.0/24"]       #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = "dev-nsg1"    #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = "dev-rg"     #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_default_outbound_access_enabled            = true
        # virtual_network_subnet_delegation = [{
        #   name = "example-delegation" # (Required) A name for this delegation.    
        #   service_delegation = [{
        #     name = "Microsoft.ContainerService/managedClusters"             #(Required) The name of the service to delegate to
        #   actions = ["Microsoft.Network/virtualNetworks/subnets/action"] }] #(Optional) A list of actions which should be delegated.
        # }]
        # virtual_network_subnet_private_link_service_network_policies_enabled = false                  #(Optional) Enable or Disable network policies for the private endpoint on the subnet. Possible values are Disabled, Enabled, NetworkSecurityGroupEnabled and RouteTableEnabled. Defaults to Disabled
        # virtual_network_subnet_route_table_name                              = "XXXXXX"               #(Optional) The Route Table to associate with the subnet.
        # virtual_network_subnet_route_table_resource_group_name               = "XXXXX"                #(Optional) The Route Table to associate with the subnet.
        #virtual_network_subnet_private_endpoint_network_policies             = "Disabled"              #(Optional) Enable or Disable network policies for the private endpoint on the subnet. Possible values are Disabled, Enabled, NetworkSecurityGroupEnabled and RouteTableEnabled. Defaults to Disabled
        # virtual_network_subnet_service_endpoints                             = ["Microsoft.Storage"]  #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web.       
        #virtual_network_subnet_service_endpoint_policy_ids                   = null                    #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
      },
      {
        virtual_network_subnet_name           = "dev-subnet02"        #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix = ["10.0.1.0/24"]       #(Required) The address prefix to use for the subnet.
      }
    ]
    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
      Owner      = "saithadepalli",
      Department = "CIS"
    }
  },
  # "virtual_network_2" = {
  #   virtual_network_name                = "XXXXXXX" #(Required) The name of the virtual network.
  #   virtual_network_location            = "eastus2"           #(Required) The location/region where the virtual network is created.
  #   virtual_network_resource_group_name = "XXXXXXXXX"   #(Required) The name of the resource group in which to create the virtual network.
  #   virtual_network_address_space       = ["11.0.0.0/16"]     #(Required) The address space that is used the virtual network.
  #   virtual_network_encryption = [
  #     {
  #       virtual_network_encryption_enforcement = "AllowUnencrypted"
  #     }
  #   ]
  #   virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
  #     Owner      = "saithadepalli",
  #     Department = "CIS"
  #   }
  # }
}

subscription_id = "XX-XXX-XX" #(Required) The Azure Subscription ID in which the Resource Group should be created
tenant_id       = "XX-XXX-XX" #(Required) The Azure Tenant ID in which the Resource Group should be created.
