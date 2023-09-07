data "azurerm_key_vault" "keyvault" {
  name                = "Shivam-vmuserlogin"
  resource_group_name = "Shivam-Resourcegroup"
}

resource "azurerm_key_vault_secret" "keyvaultsecretusername" {
  name         = var.adminusername
  value        = var.usernamevalue
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "keyvaultsecretpassword" {
  name         = var.adminpassword
  value        = var.passwordvalue
  key_vault_id = data.azurerm_key_vault.keyvault.id
}