output "common_network_internal" {
    value = openstack_networking_network_v2.internal
}

output "common_security_group" {
    value = openstack_networking_secgroup_v2.common_internal
}

output "common_keypair" {
    value = openstack_compute_keypair_v2.infra
}