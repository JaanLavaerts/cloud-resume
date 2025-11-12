resource "azurerm_resource_group" "jaan-cloud-resume" {
  name     = "jaan-cloud-resume"
  location = "West Europe"
}

resource "azurerm_static_web_app" "frontend" {
  name                = "frontend"
  resource_group_name = azurerm_resource_group.jaan-cloud-resume.name
  location            = azurerm_resource_group.jaan-cloud-resume.location
}



# outputs
output "static_web_app_url" {
  value = azurerm_static_web_app.frontend.default_host_name
}

output "deployment_token" {
  value     = azurerm_static_web_app.frontend.api_key
  sensitive = true
}
