resource "google_compute_subnetwork" "devfest-subnetork" {
  name          = "devfest-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "${google_compute_network.devfest-network.self_link}"

  secondary_ip_range {
    range_name    = "range-devfest"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "devfest-network" {
  name                    = "devfest-network"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "default" {
  name    = "devfest-ssh-http"
  network = "${google_compute_network.devfest-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}