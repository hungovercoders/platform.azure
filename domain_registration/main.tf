resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.region
  tags     = local.tags
}

resource "azurerm_eventhub_namespace" "ehns" {
  name                = local.eventhub_namespace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 1
  tags                = local.tags
}

resource "azurerm_resource_group" "domain_rg" {
  for_each = local.unique_domains
  location = var.region
  name     = "${local.environment_shortcode}-${each.value}data-rg-${var.unique_namespace}"
  tags = {
    environment  = var.environment
    organisation = var.organisation
    team         = var.team
    domain       = each.value
  }
}

resource "azurerm_storage_account" "data_lake" {
  for_each = local.unique_domains

  name                     = "${local.environment_shortcode}${each.value}dlk${local.region_shortcode}${var.unique_namespace}"
  resource_group_name      = azurerm_resource_group.domain_rg[each.value].name
  location                 = azurerm_resource_group.domain_rg[each.value].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
  tags = {
    environment  = var.environment
    organisation = var.organisation
    team         = var.team
    domain       = each.value
  }
}

resource "azurerm_role_assignment" "access_assign" {
  for_each             = local.unique_domains
  depends_on           = [azurerm_storage_account.data_lake]
  scope                = azurerm_storage_account.data_lake[each.value].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = "452f1e80-b6f7-4da9-95a1-cf2f505a9a76" //prd-catalog001-dbexc-eun-hngc
}

resource "azurerm_storage_container" "example" {
  for_each              = { for container in local.flattened_containers : "${container.storage_account_name}-${container.container_name}" => container }
  depends_on            = [azurerm_storage_account.data_lake]
  name                  = each.value.container_name
  storage_account_name  = each.value.storage_account_name
  container_access_type = "private"
}

resource "azurerm_key_vault" "kv" {
  for_each                    = local.unique_domains
  name                        = "${local.environment_shortcode}${each.value}kv${local.region_shortcode}${var.unique_namespace}"
  resource_group_name         = azurerm_resource_group.domain_rg[each.value].name
  location                    = azurerm_resource_group.domain_rg[each.value].location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  tags = {
    environment  = var.environment
    organisation = var.organisation
    team         = var.team
    domain       = each.value
  }
}

resource "azurerm_eventhub" "example" {
  for_each = { for eh in local.flattened_eventhubs : eh.name => eh }

  name                = each.value.name
  namespace_name      = azurerm_eventhub_namespace.ehns.name # Adjust accordingly
  resource_group_name = azurerm_resource_group.rg.name       # Adjust accordingly
  partition_count     = each.value.partition_count
  message_retention   = each.value.message_retention
}

resource "azurerm_eventhub_consumer_group" "example" {
  for_each            = { for cg in local.flattened_consumer_groups : "${cg.eventhub_name}-${cg.consumer_group}" => cg }
  depends_on          = [azurerm_eventhub.example]
  name                = each.value.consumer_group
  eventhub_name       = each.value.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.ehns.name # Adjust accordingly
  resource_group_name = azurerm_resource_group.rg.name       # Adjust accordingly
}