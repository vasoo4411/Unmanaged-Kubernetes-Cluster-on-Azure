# Unmanaged-Kubernetes-Cluster-on-Azure

This project is intended to allow security/kubernetes admins to create Unmanaged Kubernetes Clusters in Azure Virtual Machines. Terraform is used to Create VMs, and Ansible is used to configure K8s cluster and other dependencies. PLEASE do not modify the names of the playbook files or the folder

1. By Default it will create One K8s Cluster with One master and three does in Central India region in Azure. 
2. For this we will be creating four Virtual Machine running Ubuntu OS, with One master having public IP, other 3 nodes with No public IP. 
3. Credentials for admin user of master node can be set using variables.tf file or you can use default values specified there.

Requirements: Terraform and A valid Azure Subscription

Usage

Step 1:

Configure your terraform to use it with MSFT Azure.
Configuring TF is out of scope for this, so please follow the steps as per this article to configure https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash?tabs=bash

Step 2: 

