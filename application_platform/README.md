# Application Platform

- [Application Platform](#application-platform)
  - [Purpose](#purpose)
  - [Deployed Assets](#deployed-assets)
  - [Contribute](#contribute)
    - [Development](#development)
    - [Production Release](#production-release)

## Purpose

This platform is used to provide shared infrastructure for hungovercoder assets.

## Deployed Assets

- Azure Container App Environment
- Azure Log Analytics

## Contribute

You can contribute to the terraform in this application_platform directory and then carry out the below.

### Development

Your local environment variable called ENVIRONMENT when working should be development.

You can plan a deploy of the infrastructure to a temporary development environment from your local setup using the following command:

```bash
sh ./tools_platform/infrastructure.sh application_platform False
```

You can perform a deploy of the infrastructure to a temporary development environment from your local setup using the following command:

```bash
sh ./tools_platform/infrastructure.sh application_platform True
```

You can test a github action workflow for the dev environment too by committing in any other branch other than main. This will also tell you what will happen in production by performing a terraform plan against production too.

### Production Release

Commit your code to the main branch which will trigger a production release.
