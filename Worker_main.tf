
 resource "azurerm_linux_virtual_machine" "WorkerNodes" {
   count                 = 3
   name                  = "K8sNode${count.index}"
   location              = azurerm_resource_group.UnmanagedK8s1.location
   resource_group_name   = azurerm_resource_group.UnmanagedK8s1.name
   network_interface_ids = [element(azurerm_network_interface.NodeNICs.*.id, count.index)]
   size               = "Standard_D2_v2"
   admin_username        = var.admin_username
   admin_password        = var.admin_password
   disable_password_authentication = false


  
   source_image_reference {

    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"

  }

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

   

   tags = {
     Name = "VS"
   }


 }
