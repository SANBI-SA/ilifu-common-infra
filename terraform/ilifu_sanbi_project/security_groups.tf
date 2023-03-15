resource "openstack_networking_secgroup_v2" "common_internal" {
  name        = "(tf) common internal"
  
  description = "Managed by Terraform"

}

resource "openstack_networking_secgroup_rule_v2" "common_internal" {

  for_each          = {for item in [
    { "id": 0, "dir": "ingress", "proto": "tcp", "port_min": 22, "port_max": 22, },
    { "id": 1, "dir": "egress", "proto": "tcp", "port_min": 0, "port_max": 0 },
    { "id": 2, "dir": "egress", "proto": "udp", "port_min": 0, "port_max": 0 }
    ]: item.id => item}

  direction         = each.value.dir
  ethertype         = "IPv4"
  protocol          = each.value.proto
  port_range_min    = each.value.port_min
  port_range_max    = each.value.port_max
  remote_ip_prefix  = "172.16.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.common_internal.id

  description = "Managed by Terraform"

}

##

# resource "openstack_networking_secgroup_v2" "sentry" {
#   name        = "(tf) sentry ssh access"
  
#   description = "Managed by Terraform"

# }

# resource "openstack_networking_secgroup_rule_v2" "sentry" {

#   for_each          = {for item in [
#     {"id": 0, "dir": "ingress", "proto": "tcp", "port_min": 22, "port_max": 22, },
#     {"id": 1, "dir": "egress", "proto": "tcp", "port_min": 0, "port_max": 0},
#     {"id": 2, "dir": "egress", "proto": "udp", "port_min": 0, "port_max": 0}
#     ]: item.id => item}

#   direction         = each.value.dir
#   ethertype         = "IPv4"
#   protocol          = each.value.proto
#   port_range_min    = each.value.port_min
#   port_range_max    = each.value.port_max
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = openstack_networking_secgroup_v2.sentry.id

#   description = "Managed by Terraform"

# }

###