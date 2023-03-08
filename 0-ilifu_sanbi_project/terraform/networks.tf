resource "openstack_networking_network_v2" "internal" {

  name           = "(tf) Internal vxlan"
  admin_state_up = "true"
  
  description = "Managed by Terraform"

}
