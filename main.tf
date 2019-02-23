provider "google" {
  //use your project number
  project = "860167524118"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "devfest" {
  count        = "1"
  name         = "devfest-instance-${count.index+1}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "gce-uefi-images/cos-stable"
    }
  }

  network_interface {
    network       = "${google_compute_network.devfest-network.name}"
    access_config = {}
  }

  metadata {
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  metadata_startup_script = "docker run -p 80:80 nginx"
}
