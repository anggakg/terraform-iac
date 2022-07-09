terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "vm-${var.env_name}"
  location = "japan east"
}

resource "azurerm_virtual_network" "main" {
  name                = "network-${var.env_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal-${var.env_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "publicip" {
    name                    = "PublicIP-${var.env_name}-${count.index+1}"
    location                = azurerm_resource_group.rg.location
    resource_group_name     = azurerm_resource_group.rg.name
    allocation_method       = "Dynamic"
    count                   = var.nb_vm
}

resource "azurerm_network_interface" "main" {
  count               = var.nb_vm
  name                = "nic-${var.env_name}-${count.index+1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1-${count.index+1}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = [element(azurerm_public_ip.publicip.id, count.index+1)]
  }
}

resource "azurerm_virtual_machine" "main" {
  count               = var.nb_vm
  name                  = "vm-${var.env_name}-${count.index+1}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.main.*.id, count.index+1)]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1-${var.env_name}-${count.index+1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname-${var.env_name}-${count.index+1}"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# module "linuxservers" {
#   source              = "Azure/compute/azurerm"
#   resource_group_name = azurerm_resource_group.rg.name
#   vm_os_simple        = "UbuntuServer"
#   public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
#   vnet_subnet_id      = module.network.vnet_subnets[0]

#   depends_on = [azurerm_resource_group.rg]
# }

# module "windowsservers" {
#   source              = "Azure/compute/azurerm"
#   resource_group_name = azurerm_resource_group.example.name
#   is_windows_image    = true
#   vm_hostname         = "mywinvm" // line can be removed if only one VM module per resource group
#   admin_password      = "ComplxP@ssw0rd!"
#   vm_os_simple        = "WindowsServer"
#   public_ip_dns       = ["winsimplevmips"] // change to a unique name per datacenter region
#   vnet_subnet_id      = module.network.vnet_subnets[0]

#   depends_on = [azurerm_resource_group.example]
# }

# module "network" {
#   source              = "Azure/network/azurerm"
#   resource_group_name = azurerm_resource_group.example.name
#   subnet_prefixes     = ["10.0.1.0/24"]
#   subnet_names        = ["subnet1"]

#   depends_on = [azurerm_resource_group.example]
# }