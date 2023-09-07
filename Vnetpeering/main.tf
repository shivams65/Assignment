data "azurerm_virtual_network" "linuxvnet" {
  name                = "Linuxvnet"
  resource_group_name = "Shivam-Resourcegroup"
}

data "azurerm_virtual_network" "windowsvnet" {
  name                = "windowsvnet"
  resource_group_name = "Shivam-Resourcegroup"
}

resource "azurerm_virtual_network_peering" "vnetpeering-1" {
  name                      = "peer1to2"
  resource_group_name       = var.rgname
  virtual_network_name      = var.vnetnamelinux
  remote_virtual_network_id = data.azurerm_virtual_network.windowsvnet.id
}

resource "azurerm_virtual_network_peering" "vnetpeering-2" {
  name                      = "peer2to1"
  resource_group_name       = var.rgname
  virtual_network_name      = var.vnetnamewindows
  remote_virtual_network_id = data.azurerm_virtual_network.linuxvnet.id
}