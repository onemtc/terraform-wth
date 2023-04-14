data "azurerm_client_config" "current" {}

// yes, the following is a hack
data "external" "user" {
  program = ["az", "ad", "signed-in-user", "show", "--query", "{id:id}", "--output", "json"]
}

variable "kv_sku_name" {
  type        = string
  description = "The SKU of the vault to be created."
  default     = "standard"
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Set", "List"]
}

resource "azurerm_key_vault" "vault" {
  name                       = "${var.vaultnameprefix}${random_string.suffix.result}"
  resource_group_name        = azurerm_resource_group.tfchallenge.name
  location                   = azurerm_resource_group.tfchallenge.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.kv_sku_name
  soft_delete_retention_days = 7

  timeouts {
    create = "5m"
    delete = "5m"
  }

  access_policy {
    tenant_id          = data.azurerm_client_config.current.tenant_id
    object_id          = data.external.user.result.id
    secret_permissions = ["Set", "List"]
  }
}

