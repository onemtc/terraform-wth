# Challenge 4 - Secret Values with Azure Key Vault

[< Previous Challenge](./Terraform-Challenge-03.md) - [Home](../README.md) - [Next Challenge >](./Terraform-Challenge-05.md)

## Introduction

The goals for this challenge are to understand how to handle secret values, e.g., **Don't encode secrets in your code!**

So far, the only parameters you have passed into your template have been related to storage accounts. In a later challenge, you will deploy resources requiring secret credentials as parameters. It is an **ANTI-pattern** to put a secret value such as a password in plain text in a parameter file! NEVER do this!

It is a BEST practice to store secret values (such as passwords) in the Azure Key Vault service.

## Description

In this challenge, you will create an Azure Key Vault and store a secret in it.  Then you will create a Terraform manifest & parameters file that reads from the key vault.

## Challenges

+ Create an Azure Key Vault using [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
  + Note:  Keyvaults require a unique name in Azure.  Append your random suffix to the Keyvault name to ensure your name is unique. 
+ Using the [azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) resource provider, create a secret called `mysecret` with a [random password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) and store it in the keyvault.
+ Explore the terraform state using the `terraform state list` and `terraform state show` commands to view the state objects and specifically the secret that was created by your manifests
  + Discuss with your coach: What are the implications of the secret being stored in Terraform's state file?

## Success Criteria

* Keyvault created
* Secret stored in the keyvault


## Suggested reading:  
  + [Create an Azure key vault and key using Terraform](https://learn.microsoft.com/en-us/azure/key-vault/keys/quick-create-terraform?tabs=azure-cli)


