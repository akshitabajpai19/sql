env                              = "dev"
resource_group_name              = "resource-group-name"
vm_name_token                    = "mal-acryonm/purpose"
vm_size                          = "Standard_B1ms"
vm_admin_user                    = "login-account-id"
vm_root_pwd_keyvault_name        = "name of keyvault that has the admin password"
vm_root_pwd_keyvault_secret_name = "name of secret that has the password"
nic = { "nic1" = {
  rg                   = "rg-ccoe-github-dev-01",
  location             = "centralus",
  enable_ip_forwarding = false,
  subnet_id            = "/subscriptions/9ec2cae9-bf10-4028-904e-41d001477d85/resourceGroups/rg-vnet-ccoe-github-dev-01/providers/Microsoft.Network/virtualNetworks/vnet-ccoe-github-dev-centralus-01/subnets/snet-to-use-for-the-vm"
  name                 = "internal",
  private_ip_address   = null,
  primary              = true,
} }
os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 100
}
source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"
}
