#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string                #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string                #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = optional(string)      #(optional) The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = optional(map(string)) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}