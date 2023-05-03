
# Resources
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfchallenge" {
  name     = var.rgname
  location = var.location
}
#######################################


data "azurerm_container_registry" "myacr" {
  name                = var.acrname
  resource_group_name = var.acrrg
}


# A log analytics workspace is required for container app environments
resource "azurerm_log_analytics_workspace" "thislaw" {
  name                = "${var.lawname}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.tfchallenge.name
  location            = azurerm_resource_group.tfchallenge.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "this" {
  name                       = "my-aca-environment08"
  resource_group_name        = azurerm_resource_group.tfchallenge.name
  location                   = azurerm_resource_group.tfchallenge.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.thislaw.id
}

resource "azurerm_container_app" "storefront" {
  name                         = "storefront"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = azurerm_resource_group.tfchallenge.name
  revision_mode                = "Single"
  ingress {
    external_enabled = true
    transport        = "auto"
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  secret {
    name  = "regpwd"
    value = data.azurerm_container_registry.myacr.admin_password
  }
  registry {
    server               = data.azurerm_container_registry.myacr.login_server
    username             = data.azurerm_container_registry.myacr.admin_username
    password_secret_name = "regpwd"
  }
  template {
    container {
      name = "storefront"
      image  = "${data.azurerm_container_registry.myacr.login_server}/storefront:latest"
      cpu    = 0.25
      memory = "0.5Gi"
      env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = "Development"
      }
      env {
        name  = "ProductsApi"
        value = "https://${azurerm_container_app.product.latest_revision_fqdn}"
      }
      env {
        name  = "InventoryApi"
        value = "https://${azurerm_container_app.inventory.latest_revision_fqdn}"
      }

    }
  }
}


resource "azurerm_container_app" "inventory" {
  name                         = "inventory"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = azurerm_resource_group.tfchallenge.name
  revision_mode                = "Single"
  ingress {
    external_enabled = false
    transport        = "auto"
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  secret {
    name  = "regpwd"
    value = data.azurerm_container_registry.myacr.admin_password
  }
  registry {
    server               = data.azurerm_container_registry.myacr.login_server
    username             = data.azurerm_container_registry.myacr.admin_username
    password_secret_name = "regpwd"
  }
  template {
    container {
      name = "inventory"
      image  = "${data.azurerm_container_registry.myacr.login_server}/inventory:latest"
      // image  = "ghcr.io/onemtc/terraform-wth/inventory:latest"

      cpu    = 0.25
      memory = "0.5Gi"
      env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = "Development"
      }
    }
  }
}


resource "azurerm_container_app" "product" {
  name                         = "product"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = azurerm_resource_group.tfchallenge.name
  revision_mode                = "Single"
  ingress {
    external_enabled = false
    transport        = "auto"
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  secret {
    name  = "regpwd"
    value = data.azurerm_container_registry.myacr.admin_password
  }
  registry {
    server               = data.azurerm_container_registry.myacr.login_server
    username             = data.azurerm_container_registry.myacr.admin_username
    password_secret_name = "regpwd"
  }
  template {
    container {
      name = "product"
      image  = "${data.azurerm_container_registry.myacr.login_server}/product:latest"
      // image  = "ghcr.io/onemtc/terraform-wth/product:latest"
      cpu    = 0.25
      memory = "0.5Gi"
      env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = "Development"
      }
    }
  }
}


output "storefrontfqdn" {
  value = azurerm_container_app.storefront.latest_revision_fqdn
}



