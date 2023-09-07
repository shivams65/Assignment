data "azurerm_public_ip" "publicipaddress" {
  name                = "windowspubip01"
  resource_group_name = "Shivam-Resourcegroup"
}
output "publicip" {
  value = data.azurerm_public_ip.publicipaddress.ip_address
  }