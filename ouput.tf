# output "nginx_ingress_ip" {
#   description = "The public IP address for the NGINX Ingress."
#   value      = azurerm_public_ip.nginx_ingress_public_ip.ip_address
# }

output "nic_id" {
  value = azurerm_network_interface.nic
}

output "rg_name" {
  value = azurerm_resource_group.rg
}
