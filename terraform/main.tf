resource "azurerm_resource_group" "jaan-cloud-resume" {
  name     = "jaan-cloud-resume"
  location = "West Europe"
  tags     = { "Owner" = "Jaan", "DueDate" = "2026-01-31" }
}

resource "azurerm_container_registry" "acr-resume-jaan" {
  name                = "jaanresumecontainerreg"
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  location            = azurerm_resource_group.jaan-cloud-resume.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_linux_web_app" "jaan-resume-app" {
  name                = "jaan-resume-app"
  location            = azurerm_resource_group.jaan-cloud-resume.location
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  service_plan_id     = azurerm_service_plan.service-plan-jaan.id
  https_only          = true

  site_config {
    application_stack {
      docker_image_name        = "cloud-resume-frontend:latest"
      docker_registry_url      = "https://jaanresumecontainerreg.azurecr.io"
      docker_registry_username = azurerm_container_registry.acr-resume-jaan.admin_username
      docker_registry_password = azurerm_container_registry.acr-resume-jaan.admin_password
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_ENABLE_CI"                    = "true"
  }
}

resource "azurerm_storage_account" "st-resume-jaan" {
  name                     = "stresumejaan"
  resource_group_name      = azurerm_resource_group.jaan-cloud-resume.name
  location                 = azurerm_resource_group.jaan-cloud-resume.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "service-plan-jaan" {
  name                = "service-plan-jaan"
  location            = azurerm_resource_group.jaan-cloud-resume.location
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  sku_name            = "B1"
  os_type             = "Linux"
}

resource "azurerm_linux_function_app" "func-resume-jaan" {
  name                       = "func-resume-jaan"
  location                   = azurerm_resource_group.jaan-cloud-resume.location
  resource_group_name        = azurerm_resource_group.jaan-cloud-resume.name
  service_plan_id            = azurerm_service_plan.service-plan-jaan.id
  storage_account_name       = azurerm_storage_account.st-resume-jaan.name
  storage_account_access_key = azurerm_storage_account.st-resume-jaan.primary_access_key
  https_only                 = true
  app_settings = {
    "COSMOS_CONNECTION_STRING" = azurerm_cosmosdb_account.cosmos-resume-jaan.primary_sql_connection_string
    // set runtime for CI/CD github actions
    "FUNCTIONS_WORKER_RUNTIME" = "python"

    // enable worker indexing to make python v2 programming model functions work (fuck this setting)
    "AzureWebJobsFeatureFlags" = "EnableWorkerIndexing"
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }
    always_on = true
    cors {
      allowed_origins = ["https://${azurerm_linux_web_app.jaan-resume-app.default_hostname}"]
    }
  }
}

resource "azurerm_cosmosdb_account" "cosmos-resume-jaan" {
  name                = "cosmos-resume-jaan"
  location            = azurerm_resource_group.jaan-cloud-resume.location
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location          = azurerm_resource_group.jaan-cloud-resume.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "visitors-database" {
  name                = "visitors-database"
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  account_name        = azurerm_cosmosdb_account.cosmos-resume-jaan.name
}

resource "azurerm_cosmosdb_sql_container" "visitors-container" {
  name                = "visitors-container"
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  account_name        = azurerm_cosmosdb_account.cosmos-resume-jaan.name
  database_name       = azurerm_cosmosdb_sql_database.visitors-database.name
  throughput          = 400
  partition_key_paths = ["/id"]
}

# outputs
output "app_url" {
  value = azurerm_linux_web_app.jaan-resume-app.default_hostname
}

output "function_app_url" {
  value = azurerm_linux_function_app.func-resume-jaan.default_hostname
}

output "cosmos_db_connection_string" {
  value     = azurerm_cosmosdb_account.cosmos-resume-jaan.primary_sql_connection_string
  sensitive = true
}
