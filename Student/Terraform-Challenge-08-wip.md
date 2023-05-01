# Challenge 8 - Advanced Azure Container Apps (ACA)

[< Previous Challenge](./Terraform-Challenge-07.md) - [Home](../README.md) - [Next Challenge>](./Terraform-Challenge-09.md)

## Introduction
In the prior challenge, we ran a very simple example of using ACA to host a hello-world app.

In this challenge, we will expand on what we learned, and host a more complex two-tier application, exploring more capabilities of Azure Container Apps as well as Azure Container registry.

We will also explore the Terraform concept of "layered state files", where shared infrastructure components are deployed and managed separately from your application workloads


## Challenges

**Challenge Part 1**:  In this first part of this challenge, we are going to deploy an Azure Container registry and use it to build our container images.

First, create a new sub-folder within your working directory (eg, `acr`) and cd into it.  This will be used to host the code for your ACR definition.

Next, within this folder, create the appropriate Terraform manifest definitions to deploy an [Azure Container Registry (ACR)(https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry).
+ Deploy this to a different state file!  You can use the existing Storage Account and Blob Container, but use a (new) different key from your existing state file
+ Enable an [admin user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#admin_enabled) on this ACR, and output both the admin_username and admin_password as your outputs.  (_Yes, you would **never** output the admin_password in a real-world scenario._)

Once your container registry has been created, you'll need to import two container images to it.  As this is an _imperative_ operation, we'll use the Azure az cli to perform this task rather than terraform.  Run the following commands:
+ `az acr import --name <your registry name> --source ghcr.io/onemtc/terraform-wth/storefront:latest --image hello-world:latest


**Challenge Part 2**:  In the next part of the challenge

---------------------------------------------------------------------------------------------------------------
In this challenge you will write Bicep files that make use of modules to achieve the following:

- Separate networking resources (Virtual Network & Network Security Groups) into their own Bicep file.
- Separate the load balancer, VMSS, and its dependencies into their own Bicep files.
- Create a new Bicep template that deploys each of the modules you created.

## Success Criteria

1. Verify that the Bicep CLI does not show any errors and correctly emits an ARM template.
1. Verify in the Azure portal that all resources has been deployed.

## Learning Resources

- [VMSS - Azure Resource Manager reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachinescalesets?tabs=json)

## Tips

- Validate your Bicep files regularly by executing `bicep build mybicepfile.bicep`.

