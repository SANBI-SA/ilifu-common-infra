
resource "openstack_networking_port_v2" "control" {

  count = var.k8s_controller_count

  name = "port-k8s-cp-controller-${count.index}"

  network_id     = data.tfe_outputs.sanbi.values.common_network_internal.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = data.tfe_outputs.sanbi.values.common_network_internal_subnet.id
    ip_address = "172.16.0.${10 + count.index}"
  }

  allowed_address_pairs {
    ip_address = "172.16.0.9"
  }
  
}

resource "openstack_networking_port_v2" "worker" {

  count = var.k8s_worker_count
  name = "port-k8s-cp-worker-${count.index}"

  network_id     = data.tfe_outputs.sanbi.values.common_network_internal.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = data.tfe_outputs.sanbi.values.common_network_internal_subnet.id
    ip_address = "172.16.0.${10 + var.k8s_controller_count + count.index}"
  }

  # allowed_address_pairs {
  #   ip_address = "172.16.0.9"
  # }

}


resource "openstack_networking_port_v2" "virtual" {

  name                = "port-k8s-cp-virtual"
  network_id          = data.tfe_outputs.sanbi.values.common_network_internal.id
  admin_state_up      = true
  no_security_groups  = true

  fixed_ip {
    subnet_id = data.tfe_outputs.sanbi.values.common_network_internal_subnet.id
    ip_address = "172.16.0.9"
  }
  
}