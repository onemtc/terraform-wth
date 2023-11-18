
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
##########################################################
module "mykeyvault" {
  source = "./modules/keyvault"

  rg             = azurerm_resource_group.tfchallenge.name
  location       = azurerm_resource_group.tfchallenge.location
  vaultnameprefix = var.vaultnameprefix
}

module "myvm" {
  source = "./modules/vm"

  rg             = azurerm_resource_group.tfchallenge.name
  location       = azurerm_resource_group.tfchallenge.location
  vmname         = var.vmname
  admin_username = "azureuser"
  ssh_publickey  = tls_private_key.example_ssh.public_key_openssh
  subnet_id      = module.mynetwork.vmsubnetid
}

module "mynetwork" {
  source = "./modules/network"

  rg                 = azurerm_resource_group.tfchallenge.name
  location           = azurerm_resource_group.tfchallenge.location
  vnet_name          = var.vnetname
  address_space      = ["10.0.0.0/16"]
  vm_subnet_name = "vmSubnet"
  vm_subnet_addr_prefix = ["10.0.1.0/24"]
  bastion_host_name = "myBastionHost"
  bastion_subnet_addr_prefix = ["10.0.2.0/24"]
}

#####################################################

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh_private_key" {
  content  = tls_private_key.example_ssh.private_key_pem
  filename = "${path.module}/mysshkey"
}

# Put SSH private key in keyvault
resource "azurerm_key_vault_secret" "ssh_private_key" {
  key_vault_id = module.mykeyvault.vaultid
  name         = "sshprivatekey"
  value        = tls_private_key.example_ssh.private_key_pem

}

######################################################

# Move network resources to network module
moved {
  from = azurerm_virtual_network.vnet
  to = module.mynetwork.azurerm_virtual_network.vnet
}

moved {
  from = azurerm_subnet.vmsubnet
  to = module.mynetwork.azurerm_subnet.vmsubnet
}

moved {
  from = azurerm_subnet.bastionsubnet
  to = module.mynetwork.azurerm_subnet.bastionsubnet
}

moved {
  from = azurerm_public_ip.bastionpip
  to = module.mynetwork.azurerm_public_ip.bastionpip
}

moved {
  from = azurerm_bastion_host.bastionhost
  to = module.mynetwork.azurerm_bastion_host.bastionhost
}

# Move VM resources to vm module
moved {
  from = azurerm_network_interface.vmnic
  to = module.myvm.azurerm_network_interface.vmnic
}

moved {
  from = azurerm_linux_virtual_machine.vm
  to = module.myvm.azurerm_linux_virtual_machine.vm
}

#Move keyvault resources to keyvault module
moved {
  from = random_string.suffix
  to = module.mykeyvault.random_string.suffix
}

moved {
  from = azurerm_key_vault.vault
  to = module.mykeyvault.azurerm_key_vault.vault
}

moved {
  from = random_password.password
  to = module.mykeyvault.random_password.password
}

moved {
  from = azurerm_key_vault_secret.thissecret
  to = module.mykeyvault.azurerm_key_vault_secret.thissecret
}