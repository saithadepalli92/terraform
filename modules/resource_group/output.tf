#RESOURCE GROUP OUTPUT VALUE
output "resource_group_output" {
  value = { for k, v in azurerm_resource_group.resource_group : k => {
    id = v.id
    }
  }
  description = "resource group output values"
}