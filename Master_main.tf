resource "azurerm_linux_virtual_machine" "K8s_Master" {

  name                  = "KubeMaster"
  location              = azurerm_resource_group.UnmanagedK8s1.location
  resource_group_name   = azurerm_resource_group.UnmanagedK8s1.name
  network_interface_ids = [azurerm_network_interface.MasterNICs.id]
  size                  = "Standard_D2_v2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  disable_password_authentication = false
  #delete_os_disk_on_termination = true
  #delete_data_disks_on_termination = true

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

  depends_on = [
    azurerm_linux_virtual_machine.WorkerNodes
  ]

  connection {

  type = "ssh"
  user = var.admin_username
  password = var.admin_password
  host = self.public_ip_address

  }

  provisioner "remote-exec" {

  inline = [

  "sudo apt-get update --yes",
  "sudo apt install docker.io --yes",
  "sudo apt install ansible --yes",
  "sudo apt install sshpass --yes",
  "sudo apt install unzip --yes",
  "mkdir .kube",
  "mkdir ansible",
  "echo [ansible_server]'\n'${azurerm_network_interface.MasterNICs.private_ip_address} ansible_ssh_user=${var.admin_username} ansible_ssh_pass=${var.admin_password} ansible_sudo_pass=${var.admin_password}'\n'[ansible_client]'\n'${azurerm_network_interface.NodeNICs.0.private_ip_address} ansible_ssh_user=${var.admin_username} ansible_ssh_pass=${var.admin_password} ansible_sudo_pass=${var.admin_password}'\n'${azurerm_network_interface.NodeNICs.1.private_ip_address} ansible_ssh_user=${var.admin_username} ansible_ssh_pass=${var.admin_password} ansible_sudo_pass=${var.admin_password}'\n'${azurerm_network_interface.NodeNICs.2.private_ip_address} ansible_ssh_user=${var.admin_username} ansible_ssh_pass=${var.admin_password} ansible_sudo_pass=${var.admin_password} > /home/Testadmin/ansible/hosts",
  "sudo cp /home/${var.admin_username}/ansible/hosts /etc/ansible/hosts",
  "echo [defaults]'\n'host_key_checking = false > /home/${var.admin_username}/ansible/ansible.cfg",
  "sudo cp /home/${var.admin_username}/ansible/ansible.cfg /etc/ansible/ansible.cfg"
  ]
  }
  
  provisioner "file" {

   source = "./Playbooks/"
   destination = "/home/${var.admin_username}/ansible"

  }

provisioner "remote-exec" {

  inline = [

  "ansible-playbook ansible/step1.yaml",
  "ansible-playbook ansible/step2.yaml",
  "ansible-playbook ansible/step3.yaml",
  "ansible-playbook ansible/step4.yaml",
  "ansible-playbook ansible/step5.yaml",
  ]
  }
}
