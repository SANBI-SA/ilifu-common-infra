resource "openstack_networking_router_v2" "internet" {
    

  name                = "(tf) internet router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id

  description = "Managed by Terraform"

}

resource "openstack_networking_router_interface_v2" "internal_vxlan" {
  router_id = openstack_networking_router_v2.internet.id
  subnet_id = openstack_networking_subnet_v2.internal_vxlan.id
}