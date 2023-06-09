# Challenge 2 - Terraform expressions and Referencing resources

[< Previous Challenge](./Terraform-Challenge-01.md) - [Home](../README.md) - [Next Challenge >](./Terraform-Challenge-03.md)

## Introduction

In this challenge you will continue to modify and enhance the terraform manifest(s) created in Challenge 1. The goals for this challenge include:

+ Understanding Terraform expressions
+ Using conditionals
+ Using string interpolation
+ Referencing other resources

## Challenges

**Challenge**: Refactor your code so that your Terraform configuration blocks (eg, terraform{}, provider "azurerm" {}, and variables) are in one file (eg, main.tf), and your Azure resources are in a separate file (eg, `azure.tf`), and outputs are in a third file (eg `outputs.tf`).  _This is a general best practice for clarity_

**Challenge**: Use Terraform's [Random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs) to generate a four character suffix, and append this suffix to your storage account name (to ensure uniqueness).  _(eg if your storage account name was `mystorageaccount`, the new storage account name would be (example) `mystorageaccountX5q3`)_

**Challenge**:  If you haven't already done so, configure your storage account definition so that the `resource_group_name` and `location` properties are inherited from (eg, reference) the resource group definition.

**Challenge**: Create an input variable named `geoRedundancy` of type `bool` and use the [conditional operator](https://developer.hashicorp.com/terraform/language/expressions/conditionals) to switch the storage account sku name between `GRS` & `LRS` depending on whether the parameter value is `true` or `false`, respectively.

**Challenge**: Update the Terraform code to create a container in your storage account and modify the Terraform outputs to additionally show: 

- Storage Account Name
- Blob primary endpoint


## Success Criteria

1. Your configuration and azure resource definitions are defined in separate files.
1. Your Storage Account is named using a random suffix.
1. You are able to select GRS or LRS storage via a input parameter
1. You can create blob container in your storage account

## Learning Resources

+ [Azurerm Documentation (from Hashicorp)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
+ [Random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
+ [Conditional operator](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
