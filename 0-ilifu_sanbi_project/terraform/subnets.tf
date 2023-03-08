
resource "openstack_networking_subnet_v2" "internal_vxlan" {
  
  network_id = openstack_networking_network_v2.internal.id
  cidr       = "172.16.0.0/24"
  ip_version = 4
  name = "(tf) Internal vxlan subnet"

  enable_dhcp = true
  gateway_ip = "172.16.0.1"

  allocation_pool {
    start = "172.16.0.2"
    end = "172.16.0.254"
  }

  description = "Managed by Terraform"

}