resource "openstack_compute_instance_v2" "sentry" {
  name            = "sentry-ilifu.sanbi.ac.za"
  image_id        = var.sentry_instance_image_id
  flavor_id       = var.sentry_instance_flavor
  key_pair        = openstack_compute_keypair_v2.infra.name
  security_groups = [openstack_networking_secgroup_v2.sentry.id]

  metadata = {
    ansible_group_name = "sentry"
  }

  network {
    name = openstack_networking_network_v2.internal.name
  }
}

resource "openstack_networking_floatingip_v2" "sentry" {
  pool = var.public_ip_network_name
}

resource "openstack_compute_floatingip_associate_v2" "sentry" {
  floating_ip = openstack_networking_floatingip_v2.sentry.address
  instance_id = openstack_compute_instance_v2.sentry.id
}