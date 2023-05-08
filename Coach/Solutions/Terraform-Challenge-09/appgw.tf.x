resource "azurerm_public_ip" "appgwpip" {
  name                = "appgw-pip"
  resource_group_name = azurerm_resource_group.tfchallenge.name
  location            = azurerm_resource_group.tfchallenge.location
  allocation_method   = "Dynamic"
}


resource "azurerm_application_gateway" "network" {
  name                = "ch09appgateway"
  resource_group_name = azurerm_resource_group.tfchallenge.name
  location           = azurerm_resource_group.tfchallenge.location

  backend_address_pool {
    name = "webpool"
    fqdns = [  azurerm_container_app.web.latest_revision_fqdn ]
  }

backend_http_settings {
    name                  = "websettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
}

frontend_ip_configuration {
    name                 = "webip"
    public_ip_address_id = azurerm_public_ip.appgwpip.id
}
frontend_port {
    name = "webport"
    port = 80
}

gateway_ip_configuration {
    name      = "webgateway"
    subnet_id = azurerm_subnet.tfchallenge.id
}

}