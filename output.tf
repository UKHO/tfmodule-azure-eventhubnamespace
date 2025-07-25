# output name of eventhub namespace
output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.ehns.name
}

# output id of eventhub namespace
output "eventhub_namespace_id" {
  value = azurerm_eventhub_namespace.ehns.id
}

output "eventhubs" {
  value = module.eventhubs[*]
}