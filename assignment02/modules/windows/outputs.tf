output "windows_hostname" {
  value = values(azurerm_windows_virtual_machine.vm_win)[*].name

}

output "windows_private_ip_addresses" {
  value = values(azurerm_windows_virtual_machine.vm_win)[*].private_ip_address

}

output "windows_public_ip_addresses" {
  value = values(azurerm_windows_virtual_machine.vm_win)[*].public_ip_addresses

}

output "window_virtual_machine_ids" {
  value = values(azurerm_windows_virtual_machine.vm_win)[*].id
}
