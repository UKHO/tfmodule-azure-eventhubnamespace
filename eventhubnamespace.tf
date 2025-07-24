resource "azurerm_eventhub_namespace" "ehns" {
  provider            = azurerm.src
  name                = "${var.product_alias}-${var.service}-${var.environment}-ehns"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  capacity            = var.capacity
  tags                = var.tags
}

module "eventhubs" {
  count  = length(var.event_hubs)
  source = "github.com/ukho/terraform-azure-event-hub?ref=${var.event_hub_module_version}"
  providers = {
    src = azurerm.src
  }
  service                 = var.service
  environment             = var.environment
  role                    = var.event_hubs[count.index].role
  partition_count         = var.event_hubs[count.index].partition_count
  message_retention       = var.event_hubs[count.index].message_retention
  resource_group_name     = var.resource_group_name
  eventhub_namespace_id   = azurerm_eventhub_namespace.ehns.id
  eventhub_namespace_name = azurerm_eventhub_namespace.ehns.name
}
