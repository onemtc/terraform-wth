
terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}


variable "acrid" {
    type = string 
}

variable "imagename" {
    type = string 
}

resource "azapi_resource_action" "AcrImportImage" {
  type                   = "Microsoft.ContainerRegistry/registries@2023-01-01-preview"
  resource_id            = var.acrid
  response_export_values = ["*"]
  action                 = "importImage"
  method                 = "POST"
  body = jsonencode({
    source = {
      registryUri = "ghcr.io"
      sourceImage = "onemtc/terraform-wth/${var.imagename}:latest"
    }
    targetTags = ["${var.imagename}:latest"]
    mode       = "Force"
  })
}