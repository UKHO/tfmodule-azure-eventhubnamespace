# tfmodule-azure-elastic-eventhub-logging
Use this module to create an eventhub with an associated Elastic Azure Log Integration. 

*NOTE: Currently the Data View must be created manually...*

After this has been run the Elastic policy and data stream will be created.  To create an Elastic Data View using the new data stream you must first push logs to the event hub.  Then the data stream will appear when setting the index pattern for the new Data View.

## Requirements
- `Service` Pass in a service name for the service you want to log. To manage multiple services create multiple references to the module (see usage). 
- `EventHubNameSpace` This module requires an eventhub namespace to be created in your terraform before the module can be called. Ensure you have a depends on within the module to your EventHub Namespace.
- `Azure App Configuration` The module will create two keys in AAC `<service>:EventHubLogging:EntityPath` and `<service::EventHubLogging:EntityPath>`. These are then used to push configure your service to log to the required EventHub.
- `Elastc API Key` You require an API Key with fleet manage permissions to interact with Elastic. 



## Usage

```terraform
module "eventhub_logging" {
  source = "./path/to/this/module"
  
  # Required variables
  product_alias       = "myapp"
  service            = "api-service"
  location           = "East US"
  resource_group_name = "rg-myapp-prod"
  
  # Optional variables with examples
  name               = "myapp-eventhub"
  environment        = "production"
  sku               = "Standard"  # Basic, Standard, or Premium
  capacity          = 2           # Throughput units (1-20 for Standard)
  
  # Event Hub configurations
  event_hubs = [
    {
      role                = "logging"
      partition_count     = 4
      message_retention   = 7
      capture_description = "Capture logs for long-term storage"
    },
    {
      role                = "telemetry"
      partition_count     = 2
      message_retention   = 1
      capture_description = null
    }
  ]
  
  # Tags
  tags = {
    Environment = "production"
    Service     = "api-service"
    Owner       = "platform-team"
    CostCenter  = "engineering"
  }
}
```

### Multiple Services Example

```terraform
# Service 1: API Service
module "api_eventhub_logging" {
  source = "./path/to/this/module"
  
  product_alias       = "myapp"
  service            = "api-service"
  location           = "East US"
  resource_group_name = "rg-myapp-prod"
  
  event_hubs = [
    {
      role              = "application-logs"
      partition_count   = 4
      message_retention = 7
    }
  ]
  
  tags = {
    Environment = "production"
    Service     = "api-service"
  }
}

# Service 2: Worker Service
module "worker_eventhub_logging" {
  source = "./path/to/this/module"
  
  product_alias       = "myapp"
  service            = "worker-service"
  location           = "UK South"
  resource_group_name = "rg-myapp-prod"
  
  event_hubs = [
    {
      role              = "job-logs"
      partition_count   = 2
      message_retention = 3
    }
  ]
  
  tags = {
    Environment = "production"
    Service     = "worker-service"
  }
}
```
