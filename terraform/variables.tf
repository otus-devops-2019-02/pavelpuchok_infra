variable project {
  description = "Project ID"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable app_disk_image {
  description = "App Disk image"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "DB Disk image"
  default     = "reddit-db-base"
}

variable users {
  description = "List of users to add ssh-keys"
  type        = "list"
}

variable app_count {
  description = "Reddit app instances count"
  default     = "1"
}
