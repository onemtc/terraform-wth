# Variables
variable "rgname" {
  type = string
}
variable "location" {
  type = string
}
variable "saname" {
  type = string
}

variable "geoRedundancy" {
  type    = bool
  default = false
}

variable "containername" {
  type    = string
  default = "mycontainer"
}

variable "vaultnameprefix" {
  type    = string
  default = "mykv"
}

variable "vmname" {
  type    = string
  default = "myVM"
}

variable "vnetname" {
  type    = string
  default = "myVnet"
}