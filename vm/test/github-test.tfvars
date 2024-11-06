#subscription_id                   = "9ec2cae9-bf10-4028-904e-41d001477d85"
env                               = "dev"
resource_group_name               = "rg-ccoe-github-dev-01"
vm_name_token                     = "github-runner"
vm_size                           = "Standard_B1ms"
vm_admin_user                     = "github-action-runner"
vm_admin_pwd_keyvault_name        = "kvlumen-ccoe-githubdev04"
vm_admin_pwd_keyvault_secret_name = "ccoe-github-vm-pwd"
nic_rg                            = "rg-vnet-ccoe-github-dev-01"
nic_vnet                          = "vnet-ccoe-github-dev-centralus-01"
nic_subnet_name                   = "snet-pe-ccoe-github-dev-01"
nic = { "nic1" = {
  rg                   = "rg-ccoe-github-dev-01",
  location             = "centralus",
  enable_ip_forwarding = false,
  subnet_id            = "/subscriptions/9ec2cae9-bf10-4028-904e-41d001477d85/resourceGroups/rg-vnet-ccoe-github-dev-01/providers/Microsoft.Network/virtualNetworks/vnet-ccoe-github-dev-centralus-01/subnets/snet-pe-ccoe-github-dev-01"
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
