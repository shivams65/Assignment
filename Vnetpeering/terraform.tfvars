peering = {
  "Peering1" = {
    "vnet_name"            = "Linuxvnet"
    "resource_group_name"  = "Shivam-Resourcegroup"
    "name"                 = "peer1to2"
    "virtual_network_name" = "windowsvnet"
  },
  "Peering2" = {
    "vnet_name"            = "windowsvnet"
    "resource_group_name"  = "Shivam-Resourcegroup"
    "name"                 = "peer2to1"
    "virtual_network_name" = "Linuxvnet"
  },
}
