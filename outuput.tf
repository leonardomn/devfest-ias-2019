output "instances_ids" {
  value = "${google_compute_instance.devfest.*.instance_id}"
}

output "instances_ips" {
  value = "${google_compute_instance.devfest.*.network_interface.0.access_config.0.nat_ip}"
}