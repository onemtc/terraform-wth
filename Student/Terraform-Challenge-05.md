# Challenge 5 - Deploy a Virtual Machine

[< Previous Challenge](./Terraform-Challenge-04.md) - [Home](../README.md) - [Next Challenge >](./Terraform-Challenge-06.md)

## Introduction

In this challenge, you will put all the pieces together and extend your Terraform manifests to deploy a Virtual Machine in Azure.

The goals for this challenge include understanding:

+ Globally unique naming context and complex dependencies
+ Clean code with neat parameter and variable values
+ Figuring out what Azure resources it takes to build a VM

## Challenge

+ Extend your Terraform to deploy a virtual machine:
  + VM requirements:
    + Linux OS
    + Have terraform generate an SSH key and pass the public key to the VM.  Store the private ssh key in the keyvault.
      + Extra credit:  write your ssh private key to a local file
  + Use a resource prefix and template variables to have consistent naming of resources.

## Success Criteria

1. Verify that your virtual machine has been deployed via the Azure Portal or Azure CLI.
1. Connect to your virtual machine and verify you can login (Linux with SSH).  (You will need to grab the ssh private key from the keyvault)

## Tips

+ It's up to you if you want to start with clean slate set of manifests or if you want to extend your current manifests to include a VM.
+ Note that you will need to create a VNET, subnet, and NIC in addition to your VM.
+ You will need to use the Azure Bastion service to connect to your VM.

## Learning Resources

+ [Quickstart: Use Terraform to create a Linux VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform)
+ [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)
+ [azurerm_bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host)
+ [tls_private_key - used to create ssh keys](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)
+ [Virtual Machine - Azure Resource Manager reference](https://learn.microsoft.com/azure/templates/microsoft.compute/virtualmachines)
+ [Bastion Host - Azure Resource Manager reference](https://learn.microsoft.com/en-us/azure/templates/microsoft.network/bastionhosts)
