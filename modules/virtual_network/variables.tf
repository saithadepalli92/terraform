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

variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}

variable "virtual_network_tags" {
  description = "Tags to be applied to the virtual network resources"
  type        = map(string)
  default     = null
}
