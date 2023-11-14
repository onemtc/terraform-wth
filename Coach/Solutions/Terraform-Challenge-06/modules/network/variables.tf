variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "vnet_name" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "vm_subnet_name" {
  type = string
}
variable "vm_subnet_addr_prefix" {
  type = list(string)
}
variable "bastion_subnet_addr_prefix" {
  type = list(string)
}
variable "bastion_host_name" {
  type = string
}

