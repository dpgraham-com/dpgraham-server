# Continuous Integration - Continuous Deployment

This section covers the automation, CI/CD, and devops principles employed by this project.

## Version Control Management

This Project uses the [Trunk Based Development](https://trunkbaseddevelopment.com/) branching strategy. This strategy
employs a single main branch (AKA trunk or master) that developers continually stream small changes directly into. All
changes are merged through a pull request (PR), the feature branch must build and pass all test before being merged.

Releases are created from the main branch. The main branch, should, always be in a releasable state.

## Workflows and Pipelines

Currently, all CI/CD pipelines are implemented using [GitHub Actions](https://docs.github.com/en/actions).
GitHub Actions were chosen to act as our primary method of CI/CD because they are free for open source projects,
they are tightly integrated with GitHub, YAML syntax is easy to read and write, and it's a technology I was already
familiar with.

I am generally avoiding cloud provider CI/CD tools just because the added cost (technical and financial) and GitHub
workflows are tightly coupled with the version control system, a feature I find desirable.

### Workflow Specifications

The workflows are used to meet the following specifications:

### Source Code

1. All source files are linted and formatted before being merged into the main branch.
2. Unit tests are run prior to merging and on push to the remote repository to notify of any breaking changes ASAP.

### Infrastructure as Code (IaC)

1. All changes to the cloud infrastructure are checked for formatting and syntax errors before merging.
2. The admin (me) is notified of all changes to the cloud infrastructure prior to merging.
3. Changes to the cloud infrastructure are automatically applied from the main (trunk) branch.

### Dependencies

1. The admin is notified of dependencies that do not use a compatible license prior to merging.
2. A PR is periodically, and automatically, created to update the dependencies of the project.
3. The admin is notified of all high severity vulnerabilities in the dependencies of the project.

### Release (Continuous Deployment)

1. A changelog is automatically generated from changes to the trunk branch.
    - A release is manually created from the main branch. This serves as the final check before a deployment is created.
2. An [OCI](https://opencontainers.org/) compliant container image is automatically built and pushed to the GitHub
   container registry (for visibility).
3. An OCI compliant container image is automatically built and pushed to the GCP Artifact Registry.
4. The deployment image version is automatically updated to the recently built image located in the GCP Artifact
   Registry.