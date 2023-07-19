# define an azure CDN profile and endpoint to serve the static web app
# with a custom domain name

locals {
  # cdn name 
  cdn_name = "cdn${random_id.storage.hex}"
}

resource "azurerm_cdn_profile" "static" {
  name                = local.cdn_name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "static" {
  name                = local.cdn_name
  profile_name        = azurerm_cdn_profile.static.name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  origin_host_header  = azurerm_storage_account.static.primary_web_host
  origin {
    name      = azurerm_storage_account.static.name
    host_name = azurerm_storage_account.static.primary_web_host
  }
}

