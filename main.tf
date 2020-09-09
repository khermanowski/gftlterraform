provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    
}

resource "azurerm_resource_group" "gftlterraformgroup" {
    name     = "GfTL-Krzysztof-Azure"
    location = "westeurope"

    tags = {
        environment = "gftl"
    }
}

resource "azurerm_virtual_network" "gftlterraformnetwork" {
    name                = "GfTL-Network"
    address_space       = ["10.10.0.0/16"]
    location            = "westeurope"
    resource_group_name = azurerm_resource_group.gftlterraformgroup.name

    tags = {
        environment = "gftl"
    }
#    subnet {
#        name           = "subnet1"
#        address_prefix = "10.10.1.0/24"
#  }    
}

resource "azurerm_subnet" "gftlterraformsubnet" {
    name                 = "GfTL-Subnet1"
    resource_group_name  = azurerm_resource_group.gftlterraformgroup.name
    virtual_network_name = azurerm_virtual_network.gftlterraformnetwork.name
    address_prefix       = "10.10.1.0/24"
}

resource "azurerm_public_ip" "gftlterraformpublicip" {
    name                         = "GfTL-PublicIP"
    location                     = "westeurope"
    resource_group_name          = azurerm_resource_group.gftlterraformgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "gftl"
    }
}

resource "azurerm_network_security_group" "gftlterraformnsg" {
    name                = "GfTL-NetworkSecurityGroup"
    location            = "westeurope"
    resource_group_name = azurerm_resource_group.gftlterraformgroup.name
    
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

    tags = {
        environment = "gftl"
    }
}

resource "azurerm_public_ip" "gftlterraformpublicip" {
    name                         = "GfTL-PublicIP"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.gftlterraformgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "gftl"
    }
}
