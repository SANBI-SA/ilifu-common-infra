resource "openstack_compute_instance_v2" "controller" {
  count           = var.k8s_controller_count

  name            = "k8s-cp-controller-${count.index}"
  flavor_id       = var.k8s_controller_flavor_id
  key_pair        = data.tfe_outputs.sanbi.values.common_keypair.name
  security_groups = [
    data.tfe_outputs.sanbi.values.common_security_group.name,
    openstack_networking_secgroup_v2.common.name,
    openstack_networking_secgroup_v2.control.name
  ]

  metadata = {
    ansible_group_name = "cp-controllers,keepalived"
  }

  block_device {
    boot_index            = 0
    delete_on_termination = true
    destination_type      = "volume"
    source_type           = "image"
    uuid                  = var.k8s_controller_image_id
    volume_size           = 150
    guest_format          = "ext4"
  }

  network {
    name = data.tfe_outputs.sanbi.values.common_network_internal.name
    port = "${openstack_networking_port_v2.control[count.index].id}"
  }
}

resource "openstack_compute_instance_v2" "worker" {
  count           = var.k8s_worker_count

  name            = "k8s-cp-worker-${count.index}"
  flavor_id       = var.k8s_worker_flavor_id
  key_pair        = data.tfe_outputs.sanbi.values.common_keypair.name
  security_groups = [
    data.tfe_outputs.sanbi.values.common_security_group.name,
    #openstack_networking_secgroup_v2.common.name,
    openstack_networking_secgroup_v2.worker.name
  ]

  metadata = {
    ansible_group_name = "cp-workers"
  }

  block_device {
    boot_index            = 0
    delete_on_termination = true
    destination_type      = "volume"
    source_type           = "image"
    uuid                  = var.k8s_worker_image_id
    volume_size           = 50
    guest_format          = "ext4"
  }

  network {
    name = data.tfe_outputs.sanbi.values.common_network_internal.name
    port = "${openstack_networking_port_v2.worker[count.index].id}"
  }
}
