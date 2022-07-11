resource "azurerm_resource_group" "UnmanagedK8s1" {
   name     = "UnmanagedK8s1"
   location = "Central India"
 }

 resource "azurerm_virtual_network" "K8sNetwork" {
   name                = "K8sNetwork"
   address_space       = ["10.0.0.0/16"]
   location            = azurerm_resource_group.UnmanagedK8s1.location
   resource_group_name = azurerm_resource_group.UnmanagedK8s1.name
 }

 resource "azurerm_subnet" "K8sSubnet" {
   name                 = "OnlyK8sSub"
   resource_group_name  = azurerm_resource_group.UnmanagedK8s1.name
   virtual_network_name = azurerm_virtual_network.K8sNetwork.name
   address_prefixes     = ["10.0.2.0/24"]
 }

 resource "azurerm_public_ip" "MasterNode" {
   name = "MasterNode_IP"
   location = azurerm_resource_group.UnmanagedK8s1.location
   resource_group_name = azurerm_resource_group.UnmanagedK8s1.name
   allocation_method   = "Dynamic"
   sku                 = "Basic"
 
} 

 resource "azurerm_network_interface" "NodeNICs" {
   count               = 3
   name                = "NodeNIC${count.index}"
   location            = azurerm_resource_group.UnmanagedK8s1.location
   resource_group_name = azurerm_resource_group.UnmanagedK8s1.name

   ip_configuration {
     name                          = "testConfiguration"
     subnet_id                     = azurerm_subnet.K8sSubnet.id
     private_ip_address_allocation = "dynamic"

     
     
   }
   }
   
   resource "azurerm_network_interface" "MasterNICs" {
   name                = "MasterNIC"
   location            = azurerm_resource_group.UnmanagedK8s1.location
   resource_group_name = azurerm_resource_group.UnmanagedK8s1.name

   ip_configuration {
     name                          = "testConfiguration"
     subnet_id                     = azurerm_subnet.K8sSubnet.id
     private_ip_address_allocation = "dynamic"
     public_ip_address_id          = azurerm_public_ip.MasterNode.id
     
     
 }
 }