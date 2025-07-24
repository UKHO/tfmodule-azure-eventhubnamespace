variable "name" {
  type = string
  default = "test"
}

variable "product_alias" {
  type = string
  description = "The alias for the project"
}

variable "service" {
  type = string
  description = "The service name to be logged"
}

variable "environment" {
  type = string
  default = "Environment name or resource"
}

variable "location" {
  type = string
  description = "Location the resource will run in"
}

variable "resource_group_name" {
  type = string
  description = "Resource Group name"
}
variable "sku" {
  type = string
  description = "SKU for the Event Hub Namespace"
  default = "Standard"
}
variable "capacity" {
  type = number
  description = "Capacity for the Event Hub Namespace"
  default = 1
}
variable "tags" {
  type = map(string)
  description = "Tags to be applied to the resource"
  default = {}
}

#array of event hubs and settings
variable "event_hubs" {
  type = list(object({
    role                = string
    partition_count     = number
    message_retention   = number
    capture_description = optional(string)
  }))
  description = "List of Event Hubs with their settings"
  default     = []
}

variable "event_hub_module_version" {
  type = string
  description = "Version of the Event Hub module to use"
  default = "v0.6.0"
}