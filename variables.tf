#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string                #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string                #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = optional(string)      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = optional(map(string)) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}

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
        application_security_group_name                = optional(string) #(Optional) Application Security Group Name
        application_security_group_resource_group_name = optional(string) #(Optional) Application Security Group ResourceGroup Name
      })))                                                                # (Optional) A list of destination application security group ids
      security_rule_access    = string                                    # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
      security_rule_priority  = string                                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
      security_rule_direction = string                                    # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
    })))
    network_security_group_tags = optional(map(string)) #(Optional) A mapping of tags which should be assigned to the Network Security Group.
  }))
  description = "Map of object for network security group details"
  default     = {}
}

#DDOS protection plan variable
/*variable "network_ddos_protection_plan_variables" {
  type = map(object({
    network_ddos_protection_plan_name                = string                #(Required) Specifies the name of the Network DDoS Protection Plan. 
    network_ddos_protection_plan_resource_group_name = string                #(Required) The name of the resource group in which to create the resource.
    network_ddos_protection_plan_location            = string                #(Required) Specifies the supported Azure location where the resource exists.
    network_ddos_protection_plan_tags                = optional(map(string)) #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
  }))
  description = "Map of Network DDOS Protection plan variables"
  default     = {}
}*/

#ROUTE TABLE VARIABLES
variable "route_table_variables" {
  description = "Map of Route Table object"
  type = map(object({
    route_table_name                          = string                #(Required) The name of the route table. 
    route_table_location                      = string                #(Required) The Azure location where the resource should exist.
    route_table_resource_group_name           = string                #(Required) The name of the resource group in which to create the route table.
    route_table_bgp_route_propagation_enabled = optional(bool)        #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. Defaults to true.
    route_table_tags                          = optional(map(string)) #(Optional) A mapping of tags to assign to the resource.
    route_table_route = optional(list(object({                        #(Optional) List of objects representing routes.
      route_name                   = string                           #(Required) The name of the route.
      route_address_prefix         = string                           #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
      route_next_hop_type          = string                           #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
      route_next_hop_in_ip_address = optional(string)                 #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
    })))
  }))
  default = {}
}

#VIRTUAL NETWORK VARIABLE
variable "virtual_network_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    virtual_network_name                    = string                 #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string                 #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string                 #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string)           #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = optional(list(string)) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = optional(number)       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = optional(string)       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = optional(object({         #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool               #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string             #(Required) for the ID of DDoS Protection Plan.
    }))
    virtual_network_edge_zone = optional(string)        #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_encryption = optional(list(object({ #(Optional) A encryption block as defined below.
      virtual_network_encryption_enforcement = string   #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
    })))
    virtual_network_subnet = optional(list(object({                                        #(Optional) Subnet block configuration.
      virtual_network_subnet_name                                       = string           #(Required) Subnet name to attach to the VNet.
      virtual_network_subnet_address_prefix                             = list(string)     #(Required) Address prefix for the subnet.
      virtual_network_subnet_network_security_group_name                = optional(string) #(Optional) NSG name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = optional(string) #(Optional) NSG resource group for the subnet.
      virtual_network_subnet_default_outbound_access_enabled            = optional(bool)   #(Optional) outbound access to subnet default is enabled true.
      virtual_network_subnet_delegation = optional(list(object({
        name = string #(Required) A name for this delegation.
        service_delegation = list(object({
          name    = string                 #(Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
          actions = optional(list(string)) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
        }))
      })))

      virtual_network_subnet_private_link_service_network_policies_enabled = optional(bool)        #(Optional) Enable or Disable network policies for the private link service on the subnet. Defaults to true.
      virtual_network_subnet_route_table_name                              = optional(string)      #(Optional) The Route Table to associate with the subnet.
      virtual_network_subnet_route_table_resource_group_name               = optional(string)      #(Optional) The Route Table to associate with the subnet.
      virtual_network_subnet_private_endpoint_network_policies             = optional(string)      #(Optional) Enable or Disable network policies for the private endpoint on the subnet. Possible values are Disabled, Enabled, NetworkSecurityGroupEnabled and RouteTableEnabled. Defaults to Disabled.
      virtual_network_subnet_service_endpoints                             = optional(set(string)) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web.
      virtual_network_subnet_service_endpoint_policy_ids                   = optional(set(string)) #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    })))
    virtual_network_tags = optional(map(string)) #(Optional)a mapping of tags to assign to the resource.
  }))
  default = {}
}