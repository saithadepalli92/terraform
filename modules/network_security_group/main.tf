locals {
  security_rule_source_asg_list = flatten([
    for k, v in var.network_security_group_variables : [
      for i, j in v.network_security_group_security_rule : [
        for l, o in j.security_rule_source_application_security_group_names : [
          merge(
            {
              main_key = k, nested_key_1 = i, nested_key_2 = l, secondary_key = "source"
            },
            o
          )
        ]
      ] if j.security_rule_source_application_security_group_names != null
    ] if v.network_security_group_security_rule != null
  ])

  security_rule_destination_asg_list = flatten([
    for k, v in var.network_security_group_variables : [
      for i, j in v.network_security_group_security_rule : [
        for l, o in j.security_rule_destination_application_security_group_names : [
          merge(
            {
              main_key = k, nested_key_1 = i, nested_key_2 = l, secondary_key = "destination"
            },
            o
          )
        ]
      ] if j.security_rule_destination_application_security_group_names != null
    ] if v.network_security_group_security_rule != null
  ])
}


locals {
  final_source_asg_list      = { for k, v in data.azurerm_application_security_group.source_asg_ids : element(split(",", k), 0) => v.id... }
  final_destination_asg_list = { for k, v in data.azurerm_application_security_group.destination_asg_ids : element(split(",", k), 0) => v.id... }
}
# Fetch Source ASG IDs using Data block
data "azurerm_application_security_group" "source_asg_ids" {
  for_each            = { for x in local.security_rule_source_asg_list : "${x.main_key}:${x.nested_key_1}:${x.secondary_key},${x.nested_key_2}" => x }
  name                = each.value.application_security_group_name
  resource_group_name = each.value.application_security_group_resource_group_name
}

# Fetch Destination ASG IDs using Data block
data "azurerm_application_security_group" "destination_asg_ids" {
  for_each            = { for x in local.security_rule_destination_asg_list : "${x.main_key}:${x.nested_key_1}:${x.secondary_key},${x.nested_key_2}" => x }
  name                = each.value.application_security_group_name
  resource_group_name = each.value.application_security_group_resource_group_name
}

resource "azurerm_network_security_group" "network_security_group" {
  for_each            = var.network_security_group_variables
  name                = each.value.network_security_group_name
  resource_group_name = each.value.network_security_group_resource_group_name
  location            = each.value.network_security_group_location
  dynamic "security_rule" {
    for_each = each.value.network_security_group_security_rule != null ? each.value.network_security_group_security_rule : {}
    content {
      name                                       = security_rule.value.security_rule_name
      description                                = security_rule.value.security_rule_description
      protocol                                   = security_rule.value.security_rule_protocol
      source_port_range                          = security_rule.value.security_rule_source_port_range
      source_port_ranges                         = security_rule.value.security_rule_source_port_ranges
      destination_port_range                     = security_rule.value.security_rule_destination_port_range
      destination_port_ranges                    = security_rule.value.security_rule_destination_port_ranges
      source_address_prefix                      = security_rule.value.security_rule_source_address_prefix
      source_address_prefixes                    = security_rule.value.security_rule_source_address_prefixes
      source_application_security_group_ids      = security_rule.value.security_rule_source_application_security_group_names == null ? [] : local.final_source_asg_list["${each.key}:${security_rule.key}:source"]
      destination_address_prefix                 = security_rule.value.security_rule_destination_address_prefix
      destination_address_prefixes               = security_rule.value.security_rule_destination_address_prefixes
      destination_application_security_group_ids = security_rule.value.security_rule_destination_application_security_group_names == null ? [] : local.final_destination_asg_list["${each.key}:${security_rule.key}:destination"]
      access                                     = security_rule.value.security_rule_access
      priority                                   = security_rule.value.security_rule_priority
      direction                                  = security_rule.value.security_rule_direction
    }
  }
  tags = merge(each.value.network_security_group_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}