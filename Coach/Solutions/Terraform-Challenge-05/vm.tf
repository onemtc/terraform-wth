
# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tfchallenge.location
  resource_group_name = azurerm_resource_group.tfchallenge.name
}

# Create virtual machine subnet
resource "azurerm_subnet" "vmsubnet" {
  name                 = "vmSubnet"
  resource_group_name  = azurerm_resource_group.tfchallenge.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create bastion host subnet
resource "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.tfchallenge.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "bastionpip" {
  name                = "bastionPublicIP"
  location            = azurerm_resource_group.tfchallenge.location
  resource_group_name = azurerm_resource_group.tfchallenge.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create bastion host
resource "azurerm_bastion_host" "bastionhost" {
  name                   = "myBastionHost"
  location               = azurerm_resource_group.tfchallenge.location
  resource_group_name    = azurerm_resource_group.tfchallenge.name

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastionpip.id
  }
}

# Create virtual machine network interface
resource "azurerm_network_interface" "vmnic" {
  name                = "vmNIC"
  location            = azurerm_resource_group.tfchallenge.location
  resource_group_name = azurerm_resource_group.tfchallenge.name

  ip_configuration {
    name                          = "vm_nic_configuration"
    subnet_id                     = azurerm_subnet.vmsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh_private_key" {
  content  = tls_private_key.example_ssh.private_key_pem
  filename = "${path.module}/mysshkey"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vmname
  location              = azurerm_resource_group.tfchallenge.location
  resource_group_name   = azurerm_resource_group.tfchallenge.name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = "" # null value means use managed storage account
  }
}

# Put SSH private key in keyvault
resource "azurerm_key_vault_secret" "ssh_private_key" {
  key_vault_id = azurerm_key_vault.vault.id
  name         = "sshprivatekey"
  value        = tls_private_key.example_ssh.private_key_pem

}

############# outputs ###########################
output "ssh_publickey" {
  value = tls_private_key.example_ssh.public_key_openssh
}

output "ssh_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}
