resource "azurerm_resource_group" "resource_group" {
  for_each   = var.resource_group_variables
  name       = each.value.resource_group_name
  location   = each.value.resource_group_location
  managed_by = each.value.resource_group_managed_by
  tags       = merge(each.value.resource_group_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}