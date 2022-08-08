resource "azurerm_managed_disk" "data_disk_1" {
  for_each             = var.windows_name
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.rg
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
  
  tags = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach_1" {
  for_each           = var.windows_name
  managed_disk_id    = azurerm_managed_disk.data_disk_1[each.key].id
  virtual_machine_id = element(var.window_virtual_machine_ids, 0)[0]
  lun                = 0
  caching            = "ReadWrite"
  depends_on = [azurerm_managed_disk.data_disk_1]
}

resource "azurerm_managed_disk" "data_disk_2" {
  name                 = "linux-centos-vm1-data-disk-2"
  location             = var.location
  resource_group_name  = var.rg
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
  tags = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach_2" {
  managed_disk_id    = azurerm_managed_disk.data_disk_2.id
  virtual_machine_id = element(var.linux_virtual_machine_ids, 0)[0]
  lun                = 5
  caching            = "ReadWrite"
  depends_on         = [azurerm_managed_disk.data_disk_2]


}


resource "azurerm_managed_disk" "data_disk_3" {
  name                 = "linux-centos-vm2-data-disk-3"
  location             = var.location
  resource_group_name  = var.rg
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
  tags = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach-3" {
  managed_disk_id    = azurerm_managed_disk.data_disk_3.id
  virtual_machine_id = element(var.linux_virtual_machine_ids, 1)[1]
  lun                = 10
  caching            = "ReadWrite"
  depends_on         = [azurerm_managed_disk.data_disk_3]
}

