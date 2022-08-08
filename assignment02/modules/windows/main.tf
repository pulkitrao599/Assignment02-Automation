resource "azurerm_windows_virtual_machine" "vm_win" {
  for_each              = var.windows_name
  name                  = each.key
  resource_group_name   = var.win_rg
  location              = var.location
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.windows_nic[each.key].id]
  admin_username        = var.admin_username
  admin_password        = "Superm@n2020"
  availability_set_id   = azurerm_availability_set.windows_avs.id
  winrm_listener {
    protocol = "Http"
  }
  tags = local.common_tags

  source_image_reference {
    publisher = var.windows_publisher
    offer     = var.windows_offer
    sku       = var.windows_sku
    version   = var.windows_version
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.Os_disk_attributes["los_disk_caching"]
    storage_account_type = var.Os_disk_attributes["los_storage_account_type"]
    disk_size_gb         = var.Os_disk_attributes["los_disk-size"]
  }

}

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.win_rg
  tags = local.common_tags


  ip_configuration {
    name                          = "${each.key}-ipconfig1"
    subnet_id                     = var.subnet
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_name
  name                = "${each.key}-pip"
  resource_group_name = var.win_rg
  location            = var.location
  allocation_method   = "Dynamic"
  tags                = local.common_tags
}


resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.win_rg
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
}
