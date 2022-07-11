resource "azurerm_managed_disk" "OurDisk" {
   count                = 3
   name                 = "datadisk_existing_${count.index}"
   location             = azurerm_resource_group.UnmanagedK8s1.location
   resource_group_name  = azurerm_resource_group.UnmanagedK8s1.name
   storage_account_type = "Standard_LRS"
   create_option        = "Empty"
   disk_size_gb         = "1023"
 }

