resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.region
  tags     = local.tags
}

resource "azurerm_storage_account" "data_lake_catalog" {
  name                     = "${local.environment_shortcode}catalog001dlk${local.region_shortcode}${var.unique_namespace}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
  tags                     = local.tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "metastore_container" {
  name               = "metastore"
  storage_account_id = azurerm_storage_account.data_lake_catalog.id
}

resource "azapi_resource" "access_connector" {
  type      = "Microsoft.Databricks/accessConnectors@2022-04-01-preview"
  name      = local.databricks_external_connector
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id
  identity { type = "SystemAssigned" }
  body = jsonencode({ properties = {} })
}

resource "azurerm_role_assignment" "access_assign" {
  scope                = azurerm_storage_account.data_lake_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azapi_resource.access_connector.identity[0].principal_id
}

# resource "databricks_metastore" "metastore" {
#   name = local.databricks_metastore
#   storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
#     azurerm_storage_data_lake_gen2_filesystem.metastore_container.name,
#   azurerm_storage_account.data_lake_catalog.name)
#   force_destroy = true
# }

# resource "databricks_metastore_data_access" "metastore_data_access" {
#   depends_on   = [databricks_metastore.metastore]
#   metastore_id = databricks_metastore.metastore.id
#   name         = "access"
#   azure_managed_identity {
#     access_connector_id = azapi_resource.access_connector.id
#   }
#   is_default = true
# }

resource "databricks_catalog" "whiskey" {
  name    = "whiskey"
  comment = "this catalog is managed by terraform"
  properties = {
    purpose = "Whiskey catalog"
  }
}

resource "databricks_external_location" "whiskey_interface" {
  name = "whiskey_interface"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    "interface",
  "prdwhiskeydlkeunhngc")
  credential_name = azapi_resource.access_connector.id
  comment         = "Managed by TF"
  # depends_on = [
  #   databricks_metastore_assignment.this
  # ]
}

resource "databricks_external_location" "whiskey_internal" {
  name = "whiskey_internal"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    "internal",
  "prdwhiskeydlkeunhngc")
  credential_name = azapi_resource.access_connector.id
  comment         = "Managed by TF"
  # depends_on = [
  #   databricks_metastore_assignment.this
  # ]
}

resource "databricks_schema" "internal" {
  catalog_name = databricks_catalog.whiskey.id
  name         = "internal"
  comment      = "this schema is managed by terraform"
  storage_root = "abfss://internal@prdwhiskeydlkeunhngc.dfs.core.windows.net"
  properties = {
    kind = "various"
  }
  depends_on = [
    databricks_external_location.whiskey_internal
  ]
}