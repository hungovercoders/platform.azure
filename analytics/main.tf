resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.region
  tags     = local.tags
}

resource "azurerm_databricks_workspace" "dbw" {
  name                        = local.databricks_workspace_name
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku                         = "standard"
  tags                        = local.tags
  managed_resource_group_name = local.databricks_workspace_rg
}

resource "azurerm_databricks_workspace" "dbwp" {
  name                        = local.databricks_premium_workspace_name
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku                         = "premium"
  tags                        = local.tags
  managed_resource_group_name = local.databricks_premium_workspace_rg
}

resource "azurerm_data_factory" "adf" {
  name                = local.data_factory_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}