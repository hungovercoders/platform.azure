variable "region" {
  type        = string
  description = "The is the Azure region the resources will be deployed into."
  validation {
    condition     = contains(["northeurope", "westeurope"], var.region)
    error_message = "The region is not in the correct region, it should be northeurope or westeurope."
  }
}

variable "environment" {
  type        = string
  description = "The is the environment the resources belong to. e.g. learning, development, production."
  validation {
    condition     = contains(["learning", "development", "production"], var.environment)
    error_message = "The environment is not valid, it should be learning, development or production."
  }
}

variable "team" {
  type        = string
  description = "The is the team that own the resources."
  validation {
    condition     = contains(["datagriff", "hungovercoders", "dogadopt", "platform"], var.team)
    error_message = "The team is not valid, it should be datagriff, hungovercoders or dogadopt."
  }
}

variable "organisation" {
  type        = string
  description = "The is the organisation that owns the resources."
  validation {
    condition     = contains(["datagriff", "hungovercoders", "dogadopt"], var.organisation)
    error_message = "The organisation is not valid, it should be datagriff, hungovercoders or dogadopt."
  }
}

variable "domain" {
  type        = string
  default     = "platform"
  description = "The is the business problem domain being solved by the resources."
}

variable "unique_namespace" {
  type        = string
  default     = "hngc"
  description = "The is the unique namespace added to resources."
}



locals {
  region_shortcode              = (var.region == "northeurope" ? "eun" : var.region == "westeurope" ? "euw" : "unk")
  environment_shortcode         = (var.environment == "learning" ? "lrn" : var.environment == "development" ? "dev" : var.environment == "production" ? "prd" : "unk")
  resource_group_name           = "${local.environment_shortcode}-catalog001-rg-${var.unique_namespace}"
  databricks_external_connector = "${local.environment_shortcode}-catalog001-dbexc-${local.region_shortcode}-${var.unique_namespace}"
  databricks_metastore          = "${local.environment_shortcode}-catalog001-dbmet-${local.region_shortcode}-${var.unique_namespace}"
  databricks_metastore_default  = "default"
  databricks_metastore_access   = "${local.databricks_metastore}-access"
  tags = {
    environment  = var.environment
    organisation = var.organisation
    team         = var.team
    domain       = var.domain
  }
}

