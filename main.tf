#RESOURCE GROUP
module "resource_group" {
  source                   = "./modules/resource_group"
  resource_group_variables = var.resource_group_variables
  subscription_id          = var.subscription_id
  tenant_id                = var.tenant_id
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  source                           = "./modules/network_security_group"
  network_security_group_variables = var.network_security_group_variables
  subscription_id                  = var.subscription_id
  tenant_id                        = var.tenant_id
}

#VIRTUAL NETWORK
module "virtual_network" {
  source                    = "./modules/virtual_network"
  virtual_network_variables = var.virtual_network_variables
  subscription_id           = var.subscription_id
  tenant_id                 = var.tenant_id
}
