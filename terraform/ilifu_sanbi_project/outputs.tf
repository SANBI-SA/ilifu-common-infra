output "sentry_vm_public_ip" {
    value = openstack_networking_floatingip_v2.sentry.address
}

output "common_network_internal" {
    value = openstack_networking_network_v2.internal
}

output "common_network_internal_subnet" {
    value = openstack_networking_subnet_v2.internal_vxlan
}


output "common_security_group" {
    value = openstack_networking_secgroup_v2.common_internal
}

output "common_keypair" {
    value = openstack_compute_keypair_v2.infra
}