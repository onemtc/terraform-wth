# Challenge 6 - Terraform Modules

[< Previous Challenge](./Terraform-Challenge-05.md) - [Home](../README.md) - [Next Challenge >](./Terraform-Challenge-07.md)

## Introduction

The goals for this challenge include understanding how Terraform modules allow for granular resource management and deployment, and support separation of duties.

An application may require the composition of many underlying infrastructure resources in Azure. As you have now seen with just a single VM and its dependencies, a Terraform manifest can grow large rather quickly.

Terraform supports the concept of [*modules*](https://developer.hashicorp.com/terraform/language/modules). When you write a Bicep file you can call another Bicep file as a module. When your template is transpiled into JSON, a single ARM template is produced including the code from your module(s).

When templates get big, they become monoliths. They are hard to manage.  By breaking your templates up into smaller modules, you can achieve more flexibility in how you manage your deployments.

In many companies, deployment of cloud infrastructure may be managed by different teams. For example, a common network architecture and its security settings may be maintained by an operations team and shared across multiple application development teams.

The network architecture and security groups are typically stable and do not change frequently. In contrast, application deployments that are deployed on the network may come and go.

## Challenge

In this challenge you will separate your existing Terraform manifests deployment into modules

- Move the VM and its dependencies (VM, NIC) into their own module. (eg move into a subdirectory).  
    - The module should take the following inputs: `resource group, location, vm name, admin username, ssh public key, subnet id`
    - The module should output: `vm_host_name`
- Move the vnet, subnets, and bastion host definitions into their own module.  The module should take the following parameters:
    - `resource group, location, vnet name, address space, subnet names, subnet address prefixes`
    - The module should output: `vm_subnet_id`
- Move the keyvault into its own module. The moduel should take the following parameters:
    - `resource group, location, vault name prefix`
    - The module should output: `vault_id`

By separating the networking resources into their own modules, an application team can test its infrastructure deployment in a test network. At a later point in time, the networking module can be replaced with a production module provided by the company's operations team.

## Success Criteria

1. Verify that all resources deploy as before when you had a single terraform file ***WITHOUT ANY CHANGES.***

## Learning Resources

- [Learn Terraform modules](https://developer.hashicorp.com/terraform/tutorials/modules/module)
- [Azure Terraform Verified Modules](https://github.com/Azure/terraform-azure-modules)
- [Use Configuration to Move Resources](https://developer.hashicorp.com/terraform/tutorials/configuration-language/move-config)

