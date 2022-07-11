# Unmanaged-Kubernetes-Cluster-on-Azure

This project is intended to allow security/kubernetes admins to create Unmanaged Kubernetes Clusters in Azure Virtual Machines. 

1. By Default it will create One K8s Cluster with One master and three does in Central India region in Azure. 
2. For this we will be creating four Virtual Machine running Ubuntu OS, with One master having public IP, other 3 nodes with No public IP. 
3. Credentials for admin user of master node can be set using variables.tf file or you can use default values specified there.

