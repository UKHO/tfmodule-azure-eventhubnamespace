# output name of eventhub namespace
output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.ehns.name
}

# output id of eventhub namespace
output "eventhub_namespace_id" {
  value = azurerm_eventhub_namespace.ehns.id
}

# output event hubs created
output "event_hubs" {
  value = { for eh in azurerm_eventhub.event_hub : eh.name => {
    id                = eh.id
    name              = eh.name
    partition_count   = eh.partition_count
    message_retention = eh.message_retention
  }}
}
