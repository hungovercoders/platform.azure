# Data Analytics

- [Data Analytics](#data-analytics)
  - [Purpose](#purpose)
  - [Deployed Assets](#deployed-assets)
  - [Contribute](#contribute)
    - [Development](#development)
    - [Production Release](#production-release)

## Purpose

This platform is used to deploy the data analytics infrastructure for hungovercoder assets. This is the platform for integrating on data products across domains and teams.

## Deployed Assets

- Azure databricks workspace*
- Azure databricks data factory

At this point for any new databricks workspaces you create you will need to manually add them to the unity catalog metastore as per [data_catalog](../data_catalog/README.md).

TODO: Need to add databricks clusters per user with good config (e.g. unity catalog and time outs appropriate)

## Contribute

You can contribute to the terraform in this data_analytics directory and then carry out the below.

### Development

Your local environment variable called ENVIRONMENT when working should be development.

You can plan a deploy of the infrastructure to a temporary development environment from your local setup using the following command:

```bash
sh ./tools_platform/infrastructure.sh data_analytics False
```

You can perform a deploy of the infrastructure to a temporary development environment from your local setup using the following command:

```bash
sh ./tools_platform/infrastructure.sh data_analytics True
```

You can test a github action workflow for the dev environment too by committing in any other branch other than main. This will also tell you what will happen in production by performing a terraform plan against production too.

### Production Release

Commit your code to the main branch which will trigger a production release.
