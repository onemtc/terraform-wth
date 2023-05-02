# Challenge 8 - Advanced Azure Container Apps (ACA)

[< Previous Challenge](./Terraform-Challenge-07.md) - [Home](../README.md) - [Next Challenge>](./Terraform-Challenge-09.md)

## Introduction
In the prior challenge, we ran a very simple example of using ACA to host a hello-world app.

In this challenge, we will expand on what we learned, and host a more complex two-tier application, exploring more capabilities of Azure Container Apps as well as Azure Container registry.

We will also explore the Terraform concept of "layered state files", where shared infrastructure components are deployed and managed separately from your application workloads


## Challenges

**Challenge Part 1**:  In this first part of this challenge, we are going to deploy an Azure Container Registry (ACR) and and import some images to it.  This ACR will be governed using a separate state file from the one we've been using for our other resources.  This is a common pattern in Terraform, where you have shared infrastructure components that are deployed and managed separately from your application workloads.

First, create a new sub-folder within your working directory (eg, `acr`) and cd into it.  This will be used to host the code for your ACR definition.

Next, within this folder, create the appropriate Terraform manifest definitions to deploy an [Azure Container Registry (ACR)(https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry).
+ Deploy this to a different state file!  You can use the existing Storage Account and Blob Container, but use a (new) different key from your existing state file.  This will allow you to manage the ACR separately from the rest of your resources.
+ Be sure to enable the Admin user on the ACR.  You will need this for part 2.

We also need to import three container images into our ACR.  There's no official" way to do this using the standard `azurerm` provider, so we are going to provide a pre-authored module that you can use in your manifest.  Add the following code to your manifest:

```hcl
variable "imagenames" {
  type = list(string)
  default = [ "storefront", "product", "inventory" ]
}
module "importimage" {
  count = length(var.imagenames)
  source = "github.com/onemtc/terraform-wth/modules/importimage"

  imagename = var.imagenames[count.index]
  acrid = azurerm_container_registry.acr.id // replace this with a reference to your ACR defintion
}
```

***Success Criteria***:  Verify that the ACR is deployed and that the images are imported.  You can do this by logging into the Azure Portal and navigating to the ACR resource.  You should see the images listed under the Repositories section.


**Challenge Part 2**:  Next, we will deploy a two-tier application to Azure Container Apps.  This application will consist of a frontend web application and two backend APIs.  The application can be found in [this Github repo](https://github.com/Azure-Samples/dotNET-FrontEnd-to-BackEnd-on-Azure-Container-Apps)

![Topology](https://github.com/Azure-Samples/dotNET-FrontEnd-to-BackEnd-on-Azure-Container-Apps/raw/main/docs/media/topology.png)

+ Be sure you are using a different Terraform state file than you used in Part 1.
+ Similar to the previous challenge, deploy an [Azure Container Apps Environment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) using Terraform (and don't forget to deploy a Log Analytics Workspace to support this ACA Environment)
+ Deploy three [Azure Container Apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app) based on the images you imported in the previous step.  
    - You will need to configure an ingress to be able to access the web app from the outside (eg, Internet)
    - The app apps should not be accessible from outside of the environment.
+ For your ACA app to be able to pull the images from your ACR, you will need to reference the ACR's adminuser & password in your ACA definition.  To do this, you will need to define the ACR as a Terraform `data` source.  See [this example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) for more details.






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

