# output "publicip" {
#   value = [ for publicip in azurerm_public_ip.publicip : ip_address]
#   }

output "publicip" {
  value = [
    for windowsvm in azurerm_public_ip.publicip : windowsvm.ip_address
  ]
}

output "windowsid" {
  value = [
    for windowsvm in azurerm_windows_virtual_machine.window_vm : windowsvm.id
  ]
}