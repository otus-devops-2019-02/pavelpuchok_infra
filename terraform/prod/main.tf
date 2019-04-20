terraform {
  required_version = ">=0.11,<0.12"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source         = "../modules/app"
  zone           = "${var.zone}"
  app_disk_image = "${var.app_disk_image}"
  app_count      = "${var.app_count}"
}

module "db" {
  source        = "../modules/db"
  zone          = "${var.zone}"
  db_disk_image = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["46.53.241.92/32"]
}

resource "google_compute_project_metadata_item" "appusers" {
  key = "ssh-keys"

  # combine `users` variable with `public_key_path` and replace default user from that key with user from `users` list
  value = "${join("\n", formatlist("%s:%s%s", var.users, replace(file(var.public_key_path), "appuser\n", ""), var.users))}"
}
