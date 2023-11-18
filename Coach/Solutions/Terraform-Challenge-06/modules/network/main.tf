# Resources
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}


# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg
}

# Create virtual machine subnet
resource "azurerm_subnet" "vmsubnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vm_subnet_addr_prefix
}

# Create bastion subnet
resource "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_addr_prefix
}

# Create bastion public ip
resource "azurerm_public_ip" "bastionpip" {
  name                = "bastionPublicIP${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create bastion host
resource "azurerm_bastion_host" "bastionhost" {
  name                   = var.bastion_host_name
  location               = var.location
  resource_group_name    = var.rg

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastionpip.id
  }
}
