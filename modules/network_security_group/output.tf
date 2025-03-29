# NETWORK SECURITY GROUP OUTPUT
output "network_security_group_output" {
  description = "Network Security Group output values."
  value = { for k, v in azurerm_network_security_group.network_security_group : k => {
    id = v.id
    }
  }
}
