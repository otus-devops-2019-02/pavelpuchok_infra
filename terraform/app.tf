resource "google_compute_instance" "app" {
  name         = "reddit-app-${count.index}"
  machine_type = "f1-micro"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]
  count        = "${var.app_count}"

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "app_firewall" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
