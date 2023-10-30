variable "prefix" {
  default ="b13-ely"
}

variable "adminmail" {
  default = ["simplon.luna@gmail.com","laurent+alertes@lmathieu.com","joffreydupire@gmail.com"]
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure Region in which resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name for the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the VNet"
  type        = list(string)
}

variable "priv_subnet_name" {
  description = "The name for the subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "vm_name"{
  description = "The VM's name"
  type        = string
}

# variable "vm_size" {
#   description = "The VM size for the nodes in AKS cluster"
#   type        = string
# }

# variable "use_nat_gateway" {
#   description = "Boolean indicating whether to use NAT Gateway"
#   type        = bool
#   default     = false
# }

# variable "nat_gateway_name" {
#   description = "The name of the NAT Gateway"
#   type        = string
#   default     = "myNATGateway"
# }

# variable "nginx_ingress_ip_name" {
#   description = "The name of the public IP address resource for the NGINX Ingress."
#   type        = string
#   default     = "nginx-ingress-ip"
# }

# variable "nginx_ingress_ip_sku" {
#   description = "The SKU for the public IP address of the NGINX Ingress. Can be Basic or Standard."
#   type        = string
#   default     = "Standard"
# }

# variable "route_table_name" {
#   description = "The name of the Route Table"
#   type        = string
#   default     = "myRouteTable"
# }

# variable "next_hop_ip" {
#   description = "The IP of the next hop (for example: a firewall or other device)"
#   type        = string
#   default     = ""  # By default, leave this blank, and enforce its value when calling the module.
# }

variable "pub_ip_name" {
  description = "Name of the Public IP for VM"
  type = string
}

variable nsg_name {
  description = "VM's NSG name"
  type = string
  default = "b13-ely-nsg"
}

variable nsg_rule_name {
  description = "VM's NSG's rule name"
  type = string
  default = "b13-ely-nsg_allow-ssh"
}

variable nsgRule_priority {
  description = "Priority of the NSG rule allow_ssh"
  type = string
  default = 1001
}

variable nsgRule_direction {
  description = "Port's opening direction"
  type = string
  default = "Inbound"
}

variable nsgRule_access {
  description = "Port's opening direction access"
  type = string
  default = "Allow"
}

variable nsgRule_protocol {
  description = "Allow ssh protocol type"
  type = string
  default = "tcp"
}

variable nsgRule_source_port_range {
  description = "Authorised / Denied Port ou Range for traffic"
  type = string
  default = "*"
}

variable nsgRule_destination_port_range {
  description = "Destination port to open"
  type = string
  default = "22"
}

variable nsgRule_source_address_prefix {
  description = "Authorised IP range for traffic source"
  type = string
  default = "*"
}

variable nsgRule_destination_address_prefix {
  description = "Authorised IP range for traffic destination"
  type = string
  default = "*"
}

variable nsg_rule_name2 {
  description = "2nd VM's NSG's Rule Name"
  type = string
  default = "b13-ely-nsg_allow-outbound"
}

variable nsgRule_priority2 {
  description = "Priority of the NSG rule allow-outbound"
  type = string
  default = 2001
}

variable nsgRule_direction2 {
  description = "Port opening2 direction"
  type = string
  default = "Outbound"
}

variable nsgRule_destination_port_range2 {
  description = "Destination port2 to open"
  type = string
  default = "*"
}
