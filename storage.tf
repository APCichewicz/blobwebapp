# set up an azure storage account for a static web app
resource "azurerm_storage_account" "static" {
  name                     = "static${random_id.storage.hex}"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

# create a container in the storage account
resource "azurerm_storage_container" "function_container" {
  name                  = "vanilla-resume-function"
  storage_account_name  = azurerm_storage_account.static.name
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.static]
}

resource "azurerm_storage_blob" "static" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.static.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "./app/index.html"
  content_type           = "text/html"
  depends_on             = [azurerm_storage_account.static]
}

resource "azurerm_storage_blob" "staticcss" {
  name                   = "styles.css"
  storage_account_name   = azurerm_storage_account.static.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/css"
  source                 = "./app/styles.css"
  depends_on             = [azurerm_storage_account.static]
}

resource "azurerm_storage_blob" "staticjs" {
  name                   = "scripts.js"
  storage_account_name   = azurerm_storage_account.static.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/javascript"
  source                 = "./app/index.js"
  depends_on             = [azurerm_storage_account.static]
}


