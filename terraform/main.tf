terraform {
  backend "azurerm" {
    resource_group_name  = "#{TerraformStateResourceGroup}"
    storage_account_name = "#{TerraformStateStorageAccountName}"
    container_name       = "#{TerraformStateContainerName}"
    key                  = "#{TerraformStateBlobKey}"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "underwater-#{EnvironmentLabel}"
  location = "australiaeast"
}

resource "azurerm_service_plan" "example" {
  name                = "underwater-#{EnvironmentLabel}-plan"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "example" {
  name                = "underwater-#{EnvironmentLabel}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id
  tags = {
    "octopus-environment" = "#{Octopus.Environment.Name}"
    "octopus-role"        = "underwater-app"
  }
  site_config {}
}
