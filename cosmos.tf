resource "azurerm_cosmosdb_account" "cosmosdb-account" {
  name                = "crc-cosmosdb-account"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }
  enable_automatic_failover = false
  enable_free_tier          = true
  geo_location {
    location          = azurerm_resource_group.dev.location
    failover_priority = 0
  }
  capabilities {
    name = "EnableServerless"
  }
  capabilities {
    name = "EnableTable"
  }
}
# create a table in the cosmosdb account
resource "azurerm_cosmosdb_table" "cosmosdb-table" {
  name                = "crc-cosmosdb-table"
  resource_group_name = azurerm_resource_group.dev.name
  account_name        = azurerm_cosmosdb_account.cosmosdb-account.name
  throughput          = 400
}










