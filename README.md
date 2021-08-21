# Terraform Repository for Frobulating GOOP

# Modules


## rancher_bootstrap_project
Used to create a new Rancher Project, associate it with an AD Group and create a Kubernetes Namespace inside it.
### Required Variables
> rancher_token: API Token with sufficient privileges on Rancher Clusters."


## spinnaker_applications
Used to create a spinnaker application per service followed by a build, entrypoint, and deploy pipeline

### Dependencies
> mercari/spinnaker: https://registry.terraform.io/providers/mercari/spinnaker/latest

    Fork of the original armory-io provider that exists in the Terraform registry: https://github.com/armory-io/terraform-provider-spinnaker. This module currently does not utilize features outside of the original repository. This new maintainer may introduce more features down the road such as project creation (this is currently implemented, however revocation does not work as expected).

> hashicorp/external: https://registry.terraform.io/providers/hashicorp/external/latest

    Leveraged for calling a Python script (pipeline_template_renderer.py) that populates pipeline template files with the correct information prior to creating the actual resource

> spin CLI + config

    Along with the Spin CLI, you this provider requires a config file that contains the service account being used to authenticate with Spinnaker. Example structure:

    gate:
        endpoint: https://spinnaker-gate.k8s.qvcdev.qvc.net
    auth:
        enabled: true
        basic:
            username: ""
            password: ""

    Your local .spin/config file should work fine with this provider. However, you may explicitly specify a file with the spinnaker_cli_config variable for the pipeline

### Required Variables
> spinnaker_url: Targeted Spinnaker instance

> jenkins_url: Targeted Jenkins instance for build jobs

> jenkins_username: The username needed to authenticate with the Jenkins Instance

> jenkins_password: The password needed to authenticate with the Jenkins Instance

> applications: A collection of services to create pipelines under

> team_email: An email address to associate with each asset being created

## spinnaker_jenkins_jobs
Creates the Jenkins build job that corresponds to the Spinakker build pipeline that is created

### Dependencies

> taiidani/jenkins: https://registry.terraform.io/providers/taiidani/jenkins/latest

    Leveraged for creating the corresponding Jenkins build job that a Spinnaker build pipeline will interact with. This provider emulates the actions that a Job Generator pipeline usually performs along with the benefits of native templating and revocation.

### Required Variables

> jenkins_url: Targeted Jenkins instance for build jobs

> stash_key: The project key that will be used to create the parent directory

> stash_repo: The slug of the repository being onboarded

## spinnaker_jenkins_project_folders

Takes a string and creates a directory at the root of a Jenkins instance. We leverage this module by providing a set of all project keys being currently used within GOOP

### Dependencies

> taiidani/jenkins: https://registry.terraform.io/providers/taiidani/jenkins/latest

### Required Variables

> jenkins_url: Targeted Jenkins instance for build jobs

> stash_project_key: The project key that will be used to create the parent directory

## spinnaker_projects (TBD)
Spinnaker project creation was feasible with the provider being leveraged in this project. However, there is an issue with the revocation step where the API call cannot be made. This means any project that is created could not be removed at a later time. This work will be deferred to [IL-4503](https://jira.qvcdev.qvc.net/browse/IL-4503)

## bitbucket_webhook_creation

Creates a Bitbucket webhook for invoking the a Spinnaker entrypoint pipeline for a given application

### Dependencies

> fmontezuma/restapi: https://registry.terraform.io/providers/fmontezuma/restapi/latest

    Forked from the original repository maintained by Mastercard. This provider allows the management of resources through a generic REST api as long as the api supports full CRUD on your entity.

### Required Variables

> bb_username: The username of the account that auths with Bitbucket

> bb_password: The password of the account that auths with Bitbucket

> webhook_name: The name of the webhook that will be created

> repo_name: The repository slug of the application that the webhook will be added to

> project_key: The Bitbucket project key of the application that the webhook will be added to

> webhook_url: The url the webhook uses when an event is triggered
