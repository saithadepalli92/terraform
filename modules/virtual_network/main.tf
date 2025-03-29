locals {
  is_ddos_needed = { for k, v in var.virtual_network_variables : k => v if lookup(v, "virtual_network_ddos_protection_plan", null) != null }
  subnet_map = flatten([
    for k, v in var.virtual_network_variables : [
      for i, j in v.virtual_network_subnet :
      merge(
        {
          main_key = k, network_security_group_name = j.virtual_network_subnet_network_security_group_name, resource_group_name = j.virtual_network_subnet_network_security_group_resource_group_name
        },
        j
      ) if j.virtual_network_subnet_network_security_group_name != null
    ] if v.virtual_network_subnet != null
  ])
  route_table_map = flatten([
    for k, v in var.virtual_network_variables : [
      for i, j in v.virtual_network_subnet :
      merge({
        main_key            = k,
        route_table_name    = j.virtual_network_subnet_route_table_name,
        resource_group_name = j.virtual_network_subnet_route_table_resource_group_name
      }) if j.virtual_network_subnet_route_table_name != null
    ] if v.virtual_network_subnet != null
  ])
}

##VIRTUAL NETWORK
resource "azurerm_virtual_network" "virtual_network" {
  for_each                = var.virtual_network_variables
  name                    = each.value.virtual_network_name
  location                = each.value.virtual_network_location
  resource_group_name     = each.value.virtual_network_resource_group_name
  address_space           = each.value.virtual_network_address_space
  dns_servers             = each.value.virtual_network_dns_servers
  edge_zone               = each.value.virtual_network_edge_zone
  flow_timeout_in_minutes = each.value.virtual_network_flow_timeout_in_minutes
  #bgp_community           = each.value.virtual_network_bgp_community
  tags = var.virtual_network_tags != null ? var.virtual_network_tags : each.value.virtual_network_tags  
  }

  resource "azurerm_subnet" "subnet" {
    for_each = { for k, v in local.subnet_map : "${k}:${v.virtual_network_subnet_name}" => v }
  
    name                                          = each.value.virtual_network_subnet_name
    resource_group_name                           = var.virtual_network_variables[each.value.main_key].virtual_network_resource_group_name
    virtual_network_name                          = var.virtual_network_variables[each.value.main_key].virtual_network_name
    address_prefixes                              = each.value.virtual_network_subnet_address_prefix
    default_outbound_access_enabled              = each.value.virtual_network_subnet_default_outbound_access_enabled
    private_link_service_network_policies_enabled = each.value.virtual_network_subnet_private_link_service_network_policies_enabled
    private_endpoint_network_policies             = each.value.virtual_network_subnet_private_endpoint_network_policies
    service_endpoints                             = each.value.virtual_network_subnet_service_endpoints
    service_endpoint_policy_ids                   = each.value.virtual_network_subnet_service_endpoint_policy_ids
    depends_on = [ azurerm_virtual_network.virtual_network ]
  }