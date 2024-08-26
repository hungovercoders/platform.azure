# Data Catalog

- [Data Catalog](#data-catalog)
  - [Purpose](#purpose)
  - [Deployed Assets](#deployed-assets)
  - [Contribute](#contribute)
  - [Manual Steps](#manual-steps)
    - [Fix - Extra User to Access Catalog](#fix---extra-user-to-access-catalog)
    - [Creating Unity Catalog](#creating-unity-catalog)
    - [Adding Workspaces to Unity Catalog](#adding-workspaces-to-unity-catalog)

## Purpose

This platform is used to provide a virtualised data governance catalog over all the domain data.

## Deployed Assets

- Storage Account to Act as Default for Metastore
- Databricks Access Connector
- RBAC for the Databricks Access Connector
- Databricks Unity Catalog (manual)

## Contribute

You can contribute to the terraform in this data_catalog directory.
Please note the following:

- Unity catalog can only be one per region per account. Therefore this is only deployed once and into production.
- We may do work to setup a West Europe Unity Catalog in the future - but this will depend on changing all other development resources to point at West Europe.
- Unity catalog is setup as per the manual process below.
- Adding workspaces to unity catalog occurs as per the manual process below.

## Manual Steps

TODO

### Fix - Extra User to Access Catalog

### Creating Unity Catalog

### Adding Workspaces to Unity Catalog
