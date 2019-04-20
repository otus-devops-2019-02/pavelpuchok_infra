variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable db_disk_image {
  description = "DB Disk image"
  default     = "reddit-db-base"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}
