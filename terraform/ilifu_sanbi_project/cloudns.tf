resource "cloudns_dns_record" "sentry" {
  provider = cloudns
  name  = openstack_compute_instance_v2.sentry.name
  zone  = "sanbi.ac.za"
  type  = "A"
  value = openstack_networking_floatingip_v2.sentry.address
  ttl   = "600"
}