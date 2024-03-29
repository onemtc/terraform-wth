data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

output "aadobject_id" {
  value = data.azuread_client_config.current.object_id
}

output "azrmobject_id" {
  value = data.azurerm_client_config.current.object_id
}

variable "kv_sku_name" {
  type        = string
  description = "The SKU of the vault to be created."
  default     = "standard"
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_key_vault" "vault" {
  name                       = "${var.vaultnameprefix}${random_string.suffix.result}"
  resource_group_name        = var.rg
  location                   = var.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.kv_sku_name
  soft_delete_retention_days = 7

  timeouts {
    create = "5m"
    delete = "5m"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_client_config.current.object_id
    secret_permissions = var.secret_permissions
  }
}

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "thissecret" {
  key_vault_id = azurerm_key_vault.vault.id
  name         = "mysecret"
  value        = random_password.password.result

}