# Challenge 4: Secret Values with Azure Key Vault - Coach's Guide

[< Previous Challenge](./Solution-03.md) - **[Home](./README.md)** - [Next Challenge >](./Solution-05.md)

## Notes & Guidance

This challenge, while conceptually straightforward, has a number of "gotchas" that can complicate getting it working.

+ Make sure you are using the latest version of the azurerm provider (eg >= 3.52.0). Earlier versions had problems with timing out when configuring the AKV.
+ The terraform access_policy definitions can be tricky to get working, especially if you are using cli auth.  I found that most online examples use `data "azurerm_client_config" "current" {}` to grab the tenant id and current user id; however, this failed for me.  I was able to get it working using `data "azuread_client_config" "current" {}`.  See the file `kv.tf` for a working solution.

Also, regarding _"Discuss with your coach: What are the implications of the secret being stored in Terraform's state file?"_, one important implication is the need to secure the terraform state file. See:

+ https://techcommunity.microsoft.com/t5/fasttrack-for-azure/securing-terraform-state-in-azure/ba-p/3787254
+ https://developer.hashicorp.com/terraform/language/state/sensitive-data
+ https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables