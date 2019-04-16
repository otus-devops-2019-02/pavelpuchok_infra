terraform {
  required_version = ">=0.11,<0.12"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_project_metadata_item" "appusers" {
  key = "ssh-keys"

  # combine `users` variable with `public_key_path` and replace default user from that key with user from `users` list
  value = "${join("\n", formatlist("%s:%s%s", var.users, replace(file(var.public_key_path), "appuser\n", ""), var.users))}"
}
