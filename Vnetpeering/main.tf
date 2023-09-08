data "azurerm_virtual_network" "vnet" {
  for_each            = var.peering
  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_virtual_network_peering" "vnetpeering" {
  for_each                  = var.peering
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet[each.key].id
}