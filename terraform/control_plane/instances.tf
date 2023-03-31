resource "openstack_compute_instance_v2" "controller" {
  count           = var.k8s_controller_count

  name            = "cp-k8s-controller-${count.index}"
  flavor_id       = var.k8s_controller_flavor_id
  key_pair        = data.tfe_outputs.sanbi.values.common_keypair.name
  # security_groups = [
  #   data.tfe_outputs.sanbi.values.common_security_group.name,
  #   openstack_networking_secgroup_v2.common.name,
  # ]

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

  tags = [
    "cp-k8s-controller-etcd-${count.index}",
    "control-plane-k8s",
    "cp-k8s-controller",
    "control-plane"
  ]
}

resource "openstack_compute_instance_v2" "worker" {
  count           = var.k8s_worker_count

  name            = "cp-k8s-worker-${count.index}"
  flavor_id       = var.k8s_worker_flavor_id
  key_pair        = data.tfe_outputs.sanbi.values.common_keypair.name
  security_groups = [
    data.tfe_outputs.sanbi.values.common_security_group.name,
    #openstack_networking_secgroup_v2.common.name,
    openstack_networking_secgroup_v2.worker.name
  ]

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

  tags = [
    "control-plane-k8s",
    "cp-k8s-worker",
    "control-plane"
  ]
}
