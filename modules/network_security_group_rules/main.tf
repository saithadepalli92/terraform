locals {
  network_security_rule_source_asg_map = flatten([
    for k, v in var.network_security_rule_variables : [
      for i, j in v.network_security_rule_source_application_security_group_names : [
        merge(
          {
            main_key                                       = k,
            application_security_group_name                = j.application_security_group_name,
            application_security_group_resource_group_name = j.application_security_group_resource_group_name
          },
          j
        )
      ]
    ] if v.network_security_rule_source_application_security_group_names != null
  ])

  network_security_rule_destination_asg_map = flatten([
    for k, v in var.network_security_rule_variables : [
      for i, j in v.network_security_rule_destination_application_security_group_names : [
        merge(
          {
            main_key                                       = k,
            application_security_group_name                = j.application_security_group_name,
            application_security_group_resource_group_name = j.application_security_group_resource_group_name
          },
          j
        )
      ]
    ] if v.network_security_rule_destination_application_security_group_names != null
  ])
}


# Fetch Source ASG ID using Data block
data "azurerm_application_security_group" "source_asg_ids" {
  for_each            = { for v in local.network_security_rule_source_asg_map : "${v.main_key}:${v.application_security_group_name}" => v }
  name                = each.value.application_security_group_name
  resource_group_name = each.value.application_security_group_resource_group_name
}

# Fetch Destination ASG ID using Data block
data "azurerm_application_security_group" "destination_asg_ids" {
  for_each            = { for v in local.network_security_rule_destination_asg_map : "${v.main_key}:${v.application_security_group_name}" => v }
  name                = each.value.application_security_group_name
  resource_group_name = each.value.application_security_group_resource_group_name
}

# Network Security rule 
resource "azurerm_network_security_rule" "network_security_rule" {
  for_each                                   = var.network_security_rule_variables
  name                                       = each.value.network_security_rule_name
  resource_group_name                        = each.value.network_security_rule_resource_group_name
  network_security_group_name                = each.value.network_security_rule_network_security_group_name
  priority                                   = each.value.network_security_rule_priority
  direction                                  = each.value.network_security_rule_direction
  access                                     = each.value.network_security_rule_access
  protocol                                   = each.value.network_security_rule_protocol
  source_port_range                          = each.value.network_security_rule_source_port_range == null ? null : each.value.network_security_rule_source_port_range
  source_port_ranges                         = each.value.network_security_rule_source_port_ranges == null ? null : each.value.network_security_rule_source_port_ranges
  destination_port_range                     = each.value.network_security_rule_destination_port_range == null ? null : each.value.network_security_rule_destination_port_range
  destination_port_ranges                    = each.value.network_security_rule_destination_port_ranges == null ? null : each.value.network_security_rule_destination_port_ranges
  source_address_prefix                      = each.value.network_security_rule_source_address_prefix == null ? null : each.value.network_security_rule_source_address_prefix
  source_address_prefixes                    = each.value.network_security_rule_source_address_prefixes == null ? null : each.value.network_security_rule_source_address_prefixes
  destination_address_prefix                 = each.value.network_security_rule_destination_address_prefix == null ? null : each.value.network_security_rule_destination_address_prefix
  destination_address_prefixes               = each.value.network_security_rule_destination_address_prefixes == null ? null : each.value.network_security_rule_destination_address_prefixes
  description                                = each.value.network_security_rule_description == null ? null : each.value.network_security_rule_description
  source_application_security_group_ids      = each.value.network_security_rule_source_application_security_group_names == null ? [] : [for k, v in each.value.network_security_rule_source_application_security_group_names : data.azurerm_application_security_group.source_asg_ids["${each.key}:${v.application_security_group_name}"].id]
  destination_application_security_group_ids = each.value.network_security_rule_destination_application_security_group_names == null ? [] : [for k, v in each.value.network_security_rule_destination_application_security_group_names : data.azurerm_application_security_group.destination_asg_ids["${each.key}:${v.application_security_group_name}"].id]
}