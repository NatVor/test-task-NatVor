# main.tf

provider "azurerm" {
  features {}
  subscription_id = "b9524f11-a992-45be-8cbe-8071c1eb6be7"
}

# Define resource group
resource "azurerm_resource_group" "main" {
  name     = "webapp-resource-group"
  location = "East US"
}

# Define virtual network
resource "azurerm_virtual_network" "main" {
  name                = "webapp-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Define a single subnet for both web and db VMs
resource "azurerm_subnet" "main" {
  name                 = "main-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define SSH Key
#resource "azurerm_ssh_public_key" "web" {
#  name                = "web-ssh-key"
#  resource_group_name = azurerm_resource_group.main.name
#  public_key          = file("/home/azureuser/azure-ansible.pub")  # Use public SSH key file here
#  location            = azurerm_resource_group.main.location
#}

# Define network security group for both web server and database
resource "azurerm_network_security_group" "main" {
  name                = "webapp-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-mysql"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Define VMs with SSH Key (using smaller B1s size)
resource "azurerm_linux_virtual_machine" "web" {
  name                = "web-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"  # Use smaller B1s size
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.main.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }


  #ssh_key {
  #  path     = "/home/azureuser/azure-ansible.pub"
  #  key_data = azurerm_ssh_public_key.web.public_key
  #}
}

resource "azurerm_linux_virtual_machine" "db" {
  name                = "db-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"  # Use smaller B1s size
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.main.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  #ssh_key {
  #  path     = "/home/azureuser/.ssh/authorized_keys"
  #  key_data = azurerm_ssh_public_key.web.public_key
    # key_data = file("/home/azureuser/azure-ansible.pub")
  #}
}

# Network Interfaces (shared for both VMs)
resource "azurerm_network_interface" "main" {
  name                = "webapp-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "webapp-nic-ipconfig"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }

# Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "main" {
#  network_interface_id      = azurerm_network_interface.main.id
#  network_security_group_id = azurerm_network_security_group.main.id
#}

#azurem_network_security_group {
#    id = azurerm_network_security_group.main.id
#  }
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
