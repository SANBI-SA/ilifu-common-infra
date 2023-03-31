resource "openstack_networking_secgroup_v2" "common" {
  name                 = "(tf) k8s cp common"
  delete_default_rules = true
  
  description = "Managed by Terraform"

}

resource "openstack_networking_secgroup_rule_v2" "common" {

  for_each          = {for item in [
    { "dir": "ingress" },
    { "dir": "egress" }
    ]: item.dir => item}

  direction         = each.value.dir
  ethertype         = "IPv4"
  protocol          = "vrrp"
  remote_ip_prefix  = "172.16.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.common.id

  description = "Managed by Terraform"

}

##

resource "openstack_networking_secgroup_v2" "worker" {
  name                 = "(tf) k8s cp workers"
  delete_default_rules = true
  
  description = "Managed by Terraform"

}

resource "openstack_networking_secgroup_rule_v2" "worker_internal" {

  for_each          = {for item in [
    { "id": 0, "dir": "ingress", "proto": "tcp", "port_min": 10250, "port_max": 10250, },
    { "id": 1, "dir": "ingress", "proto": "tcp", "port_min": 30000, "port_max": 32767, },
    ]: item.id => item}

  direction         = each.value.dir
  ethertype         = "IPv4"
  protocol          = each.value.proto
  port_range_min    = each.value.port_min
  port_range_max    = each.value.port_max
  remote_ip_prefix  = "172.16.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.worker.id

  description = "Managed by Terraform"

}

resource "openstack_networking_secgroup_rule_v2" "worker_external" {

  for_each          = {for item in [
    { "id": 0, "dir": "ingress", "proto": "tcp", "port_min": 30000, "port_max": 32767, },
    ]: item.id => item}

  direction         = each.value.dir
  ethertype         = "IPv4"
  protocol          = each.value.proto
  port_range_min    = each.value.port_min
  port_range_max    = each.value.port_max
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.worker.id

  description = "Managed by Terraform"

}