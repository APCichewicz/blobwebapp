# create an azure function using the httptrigger template for python to contact the cosmosdb table with input and output bindings

resource "azurerm_service_plan" "crc-service-plan" {
  name                = "crc-service-plan"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "app" {
  name                = "crc-function-app-01"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  service_plan_id     = azurerm_service_plan.crc-service-plan.id

  storage_account_name       = azurerm_storage_account.static.name
  storage_account_access_key = azurerm_storage_account.static.primary_access_key

  site_config {
    application_stack {
      python_version = "3.10"
    }
    cors {
      allowed_origins = ["*"]
    }
  }
  #   set up to run the function app from a zip file in the storage account static in the container vanilla-resume-function
  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "python"
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
  }
}

resource "null_resource" "compress_archive" {
  triggers = {
    timestamp = timestamp()
  }
  provisioner "local-exec" {
    command     = <<EOT
    cd ..\vanilla-resume-function
    func azure functionapp publish ${azurerm_linux_function_app.app.name} --python
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}
