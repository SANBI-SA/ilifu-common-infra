resource "openstack_compute_instance_v2" "control-plane" {
  count           = 2

  name            = "control-${count.index}"
  image_id        = var.control_node_image_id
  flavor_id       = var.control_node_image_flavor
  key_pair        = data.tfe_outputs.sanbi.values.common_keypair.name
  security_groups = [
    data.tfe_outputs.sanbi.values.common_security_group.name
  ]

  metadata = {
    ansible_group_name = "control"
  }

  network {
    name = data.tfe_outputs.sanbi.values.common_network_internal.name
  }
}
