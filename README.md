# tfmodule-azure-eventhubnamespace

Use this module to create an eventhub namespace. 

After this has been run the Elastic policy and data stream will be created.  To create an Elastic Data View using the new data stream you must first push logs to the event hub.  Then the data stream will appear when setting the index pattern for the new Data View.

## Requirements

- `Service` Pass in a service name for the service you want to log. To manage multiple services create multiple references to the module (see usage). 
- `EventHubNameSpace` This module requires an eventhub namespace to be created in your terraform before the module can be called. Ensure you have a depends on within the module to your EventHub Namespace.

## Usage

```terraform
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

module "producteventhub" {
  source = "github.com/ukho/tfmodule-azure-eventhubnamespace?ref=[version]"
  
  product       = "myapp"
  location           = "UK South"
  resource_group_name = "rg-myapp-prod"
  environment        = "prd"
  
  # Optional variables with examples
  sku               = "Standard"  # Basic, Standard, or Premium
  capacity          = 2           # Throughput units (1-20 for Standard)
  tags = {}
  
  # Event Hub configurations
  event_hubs = [
    {
      service             = "api"
      role                = "logging"
      partition_count     = 4
      message_retention   = 7
      capture_description = "Capture logs for long-term storage"
    },
    {
      service             = "api"
      role                = "telemetry"
      partition_count     = 2
      message_retention   = 1
    }
  ]
  
```
