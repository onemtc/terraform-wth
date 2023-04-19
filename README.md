# What The Hack: Infrastructure As Code with Terraform

## Introduction

DevOps is a journey not a destination. Implementing Infrastructure-as-Code is one of the first steps you will need to take!

When implementing an application environment in the cloud, it is important to have a repeatable way to deploy the underlying infrastructure components as well as your software into the target environment.  This includes resources such as:
- Virtual Networks, Network Security Groups (Firewalls), Public IPs, Virtual Machines, Storage (Disks)
- PaaS Services (Azure Container Apps, Azure SQL, App Service, etc)
- Configuration Management (installing & configuring software on VMs)

The best way to make deployments repeatable is to define them with code, hence the term "Infrastructure as Code" (aka IAC).  There are multiple technologies that enable you to achieve this. Some of these include:
- ARM Templates
- Bicep Templates
- HashiCorp's Terraform
- Ansible, Chef, Puppet, Salt Stack, and others

This hack is focused on using Terraform to implement your IaC.

## Learning Objectives

This hack will help you learn:
- How Terraform can be used to deploy Azure infrastructure

The challenges build upon each other incrementally. You will start by creating basic Terraform manifests to get you familiar with the tools & syntax.  Then you extend your manifests incrementally to deploy multiple infrastructure resources to Azure.

### Challenges

- Challenge 0: **[Pre-Requisites - Ready, Set, Go!](./Student/Terraform-Challenge-00.md)**
   - Prepare your workstation to work with Azure & Terraform

---


- Challenge 1: **[Basic Terraform](./Student/Terraform-Challenge-01.md)**
   - Develop a simple Terraform manifest that takes inputs to create an Azure Storage Account, and returns outputs
- Challenge 2: **[Terraform expressions and referencing resources](./Student/Terraform-Challenge-02.md)**
   - Learn Terraform expressions, conditionals, and referencing resources
- Challenge 3: **[Advanced resource declarations](./Student/Terraform-Challenge-03.md)**
   - Advanced resource declarations including iteration
- Challenge 4: **[Secret Values with Azure Key Vault](./Student/Terraform-Challenge-04.md)**
   - Create and reference an Azure Key Vault
- Challenge 5: **[Deploy a Virtual Machine](./Student/Terraform-Challenge-05.md)**
   - Create a complex deployment with multiple dependencies
- Challenge 6: **[Terraform Modules](./Student/Terraform-Challenge-06.md)**
   - Learn how create resusable modules for granular resource management
   
   
   
- Challenge 7: **[Configure VM to run a Web Server](./Student/Bicep-Challenge-07.md)**
   - Learn about custom script extensions
- Challenge 8: **[Deploy a Virtual Machine Scale Set](./Student/Bicep-Challenge-08.md)**
   - Create complex deployment with Bicep using modules
- Challenge 9: **[Configure VM Scale Set to run a Web Server](./Student/Bicep-Challenge-09.md)**
   - Learn about custom script extensions with VM Scale Sets
- Challenge 10: **[Configure VM Scale Set to run a Web Server using cloud-init](./Student/Bicep-Challenge-10.md)**
   - How cloud-init scripts can be run on a Virtual Machine Scale Set (VMSS)
- Challenge 11: **[Deploy resources to different scopes](./Student/Bicep-Challenge-11.md)**
   - Learn how to deploy resources to different scopes   
- Challenge 20: **[Deploy an Azure App Service](./Student/Bicep-Challenge-20.md)**
   - Learn how to an Azure App Service & deploy an app to it   
- Challenge 21: **[Deploy an AKS cluster](./Student/Bicep-Challenge-21.md)**
   - Learn how to an AKS cluster & deploy an app to it   




## Prerequisites

You will want to prepare your machine with the following to help complete the Challenges for this hack:

* Azure Subscription
* _optional_ [Windows Subsystem for Linux (Windows 10-only)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [PowerShell Cmdlets for Azure](https://docs.microsoft.com/en-us/powershell/azure/?view=azps-5.6.0)
* [Visual Studio Code](https://code.visualstudio.com/)
* Bicep plugins for VS Code
	* [Bicep VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
	* [Bicep CLI](https://github.com/Azure/bicep/blob/main/docs/installing.md)

## Repository Contents 
- `../Student`
  - Bicep challenges
- `../Student/Resources`
  - Shell scripts needed to complete the challenges

## Contributors

- Victor Viriya-ampanond
- William Salazar 
- Peter Laudati
- Pete Rodriguez
- Tim Sullivan
- Mark Garner
- Jesse Mrasek
- Andy Huang
