# Platform.Azure.Compute

This project deploys platform azure infrastructure for compute resources for hungovercoder assets.

- Azure container environment
- Log analytics workspace

- [Platform.Azure.Compute](#platformazurecompute)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
  - [Contribute](#contribute)
    - [Domain Registration](#domain-registration)
    - [Application Platform](#application-platform)
    - [Data Analytics](#data-analytics)
    - [Data Catalog](#data-catalog)
  - [Tools Platform](#tools-platform)

## Prerequisites

- [Github Account](https://www.github.com/)
- [Gitpod](https://gitpod.io/)
- [Gitpod Browser Extension](https://www.gitpod.io/docs/configure/user-settings/browser-extension) (optional)
- [Visual Studio Code](https://code.visualstudio.com/) (optional but recommended for any workloads requiring Microsoft VS code extensions)
- [Setup Instructions to Utilise this Repository](https://github.com/hungovercoders/Template.Azure.Terraform/WIKI.md)

## Getting Started

1. Open the repository in gitpod.
2. Note the terminals on the right hand side
   - Versions: Will show you the versions of the tools installed
   - Azure CLI: Will show you the installation of the Azure CLI
   - Azure Storage: Will show you whether the state resource group and storage is created
   - Terraform {platform_type}: Will show you the current terraform plan against the development environment.

## Contribute

This repo deploys distinct sets of infrastructure the hungovercoder assets. Please follow the README in each of the following sections to contribute to an appropriate part of the platform.

### Domain Registration

- This infrastructure deploys historical storage for each domain and the event hub namespace and event hubs for each domain event.
- [README](./domain_registration/README.md)

### Application Platform

- This infrastructure deploys neccessary application infrastructure for new software to be built upon.
- [README](./data_analytics/README.md)

### Data Analytics

- This infrastructure deploys data factories and databricks workspaces for teams.
- [README](./data_analytics/README.md)

### Data Catalog

- This infrastructure deploys databricks unity catalog.
- [README](./data_catalog/README.md)

## Tools Platform

In the [tools_platform](./tools_platform/azure.sh), you will find a number of scripts that will help you to manage the infrastructure and environment. These are leveraged in the cloud developer environments (gitpod and codespaces) and as part of the github actions.

- [Azure Login](./tools_platform/azure_login.sh): Logins in to Azure using the CLI using your own credentials.
- [Azure Login Service Principle](./tools_platform/azure_login_service_principal.sh): Logins in to Azure using the CLI using your the service principle setup in your environment variables.
- [Environment Variables](./tools_platform/environment_variables.sh): Displays your environment variables.
- [Environment Versions](./tools_platform/environment_versions.sh): Displays the versions of the tools in your environment.
- [Git Status](./tools_platform/git_status.sh): The current status of your git branches.
- [Infrastructure State Storage](./tools_platform/infrastructure_state_storage.sh): Deploys the storage account in Azure to hold your infrastructure state.
- [Infrastructure](./tools_platform/infrastructure.sh): Plans your infrastructure deploy or deploys it if the argument True is passed.

## Authentication

Currently using aprg-hungovercoders-dev-admin account globally. This includes databricks metastore actions. For more secure practices more isolation per platform area and environment should be used. TODO: 
