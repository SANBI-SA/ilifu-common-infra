data "openstack_networking_network_v2" "public" {

  name = var.public_ip_network_name
  
}