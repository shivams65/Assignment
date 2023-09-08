data "azurerm_subnet" "subnet" {
  name                 = "subnet-1"
  virtual_network_name = "windowsvnet"
  resource_group_name  = "Shivam-Resourcegroup"
}

data "azurerm_key_vault" "keyvault" {
  name                = "Shivam-vmuserlogin"
  resource_group_name = "Shivam-Resourcegroup"
}

data "azurerm_key_vault_secret" "keyvaultsecret1" {
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "keyvaultsecret2" {
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_public_ip" "publicip" {
    for_each = var.windowsvm
  name                = each.value.publicipname
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "windowsnic" {
    for_each = var.windowsvm
  name                = each.value.nicname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip[each.key].id
  }
}

resource "azurerm_windows_virtual_machine" "window_vm" {
    for_each = var.windowsvm
  name                = each.value.vmname
  resource_group_name = var.rgname
  location            = var.location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.keyvaultsecret1.value
  admin_password      = data.azurerm_key_vault_secret.keyvaultsecret2.value
  network_interface_ids = [
    azurerm_network_interface.windowsnic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-10"
    sku       = "win10-21h2-ent"
    version   = "latest"
  }
}