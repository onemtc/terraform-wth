# Challenge 8 - Advanced Azure Container Apps (ACA)

[< Previous Challenge](./Terraform-Challenge-07.md) - [Home](../README.md) - [Next Challenge>](./Terraform-Challenge-09.md)

## Introduction
In the prior challenge, we ran a very simple example of using ACA to host a hello-world app.

In this challenge, we will expand on what we learned, and host a more complex two-tier application, exploring more capabilities of Azure Container Apps as well as Azure Container registry.

We will also explore the Terraform concept of "layered state files", where shared infrastructure components are deployed and managed separately from your application workloads


## Challenges

**Challenge Part 1**:  In this first part of this challenge, we are going to deploy an Azure Container registry and use it to build our container images.

First, create a new sub-folder within your working directory (eg, `acr`) and cd into it.  This will be used to host the code for your ACR definituiobn

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

