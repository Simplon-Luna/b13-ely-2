# Creation RG
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

# Creation VNet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = "${var.address_space}"
}

# Creation Private SubNet
resource "azurerm_subnet" "priv_subnet" {
  name                 = "${var.priv_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes     = "${var.subnet_address_prefixes}"
}


# Creation VM Pub IP
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.pub_ip_name}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Static"  # You can change this to "Static" if needed
  sku                 = "Standard"
}

# Creation NIC
resource "azurerm_network_interface" "nic" {
  name                = "ely-nic"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.priv_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = "${azurerm_public_ip.vm_public_ip.id}"
  }
}

# Creation NSG VM
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

# Creation NSG rules VM
resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "${var.nsg_rule_name}"
  priority                    = "${var.nsgRule_priority}"
  direction                   = "${var.nsgRule_direction}"
  access                      = "${var.nsgRule_access}"
  protocol                    = "${var.nsgRule_protocol}"
  source_port_range           = "${var.nsgRule_source_port_range}"
  destination_port_range      = "${var.nsgRule_destination_port_range}"
  source_address_prefix       = "${var.nsgRule_source_address_prefix}"
  destination_address_prefix  = "${var.nsgRule_destination_address_prefix}"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ssh_rule2" {
  name                        = "${var.nsg_rule_name2}"
  priority                    = "${var.nsgRule_priority2}"
  direction                   = "${var.nsgRule_direction2}"
  access                      = "${var.nsgRule_access}"
  protocol                    = "${var.nsgRule_protocol}"
  source_port_range           = "${var.nsgRule_source_port_range}"
  destination_port_range      = "${var.nsgRule_destination_port_range2}"
  source_address_prefix       = "${var.nsgRule_source_address_prefix}"
  destination_address_prefix  = "${var.nsgRule_destination_address_prefix}"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Associate security group with network interface
resource "azurerm_network_interface_security_group_association" "nsgAssociation" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# # Creation VM
# resource "azurerm_linux_virtual_machine" "red-vm" {
#   name                = "${var.vm_name}"
#   location            = "${var.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   network_interface_ids = [azurerm_network_interface.nic.id]

#   size                = "${var.vm_size}"
#   admin_username      = "adminuser"
#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/git/b13-ely/.ssh/ssh.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#   }

#   source_image_reference {
#     publisher = "RedHat"
#     offer     = "RHEL"
#     sku       = "88-gen2"
#     version   = "latest"
#   }

#   computer_name  = "${var.vm_name}"
#  }

#### Unused resources ####

# # Creation NAT Gateway
# resource "azurerm_nat_gateway" "nat_gw" {
#   count               = "${var.use_nat_gateway ? 1 : 0}"
#   name                = "${var.nat_gateway_name}"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   sku_name            = "Standard"
# }

# # Creation NAT Gateway Association
# resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gw_assoc" {
#   count                = "${var.use_nat_gateway ? 1 : 0}"
#   subnet_id            = "${azurerm_subnet.priv_subnet.id}"
#   nat_gateway_id       = "${azurerm_nat_gateway.nat_gw.*.id[0]}"
# }

# # Creation Ingress
# resource "azurerm_public_ip" "nginx_ingress_public_ip" {
#   name                = "${var.nginx_ingress_ip_name}"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   allocation_method   = "Static"
#   sku                 = "${var.nginx_ingress_ip_sku}"
# }

# # Creation Route Table
# resource "azurerm_route_table" "rt" {
#   name                = "${var.route_table_name}"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"

#   route {
#     name                = "myRoute"
#     address_prefix      = "0.0.0.0/0"
#     next_hop_type       = "VirtualAppliance"
#     next_hop_in_ip_address = var.next_hop_ip != "" ? var.next_hop_ip : azurerm_public_ip.nginx_ingress_public_ip.ip_address
#   }
# }

# # Creation Route Table Association
# resource "azurerm_subnet_route_table_association" "subnet_rt_assoc" {
#   subnet_id      = "${azurerm_subnet.priv_subnet.id}"
#   route_table_id = "${azurerm_route_table.rt.id}"
# }