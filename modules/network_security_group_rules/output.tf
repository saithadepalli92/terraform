# NETWORK SECURITY RULE OUTPUT
output "network_security_rule_output" {
  value = { for k, v in azurerm_network_security_rule.network_security_rule : k => {
    id = v.id
    }
  }
  description = "network security group rules output values."
}