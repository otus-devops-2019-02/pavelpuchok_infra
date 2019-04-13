terraform {
  required_version = ">=0.11,<0.12"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app-${count.index}"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]
  count        = "${var.app_count}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "puma-firewall" {
  name = "allow-puma-default"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["reddit-app"]
}

resource "google_compute_project_metadata_item" "appusers" {
  key = "ssh-keys"

  # combine `users` variable with `public_key_path` and replace default user from that key with user from `users` list
  value = "${join("\n", formatlist("%s:%s%s", var.users, replace(file(var.public_key_path), "appuser\n", ""), var.users))}"
}
