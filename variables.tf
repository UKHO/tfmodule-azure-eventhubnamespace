variable "product" {
  type = string
  description = "The product name (no spaces)"
}

variable "environment" {
  type = string
  description = "Environment name or resource (no spaces)"
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
    service             = string
    role                = string
    partition_count     = number
    message_retention   = number
    capture_description = optional(string)
  }))
  description = "List of Event Hubs with their settings"
  default     = []
}
