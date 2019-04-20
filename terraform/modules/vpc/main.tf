resource "google_compute_firewall" "ssh_firewall" {
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}
