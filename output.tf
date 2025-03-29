#VIRTUAL NETWORK OUTPUT
output "virtual_network_output" {
  value       = module.virtual_network.virtual_network_output
  description = "The virtual network output values"
}