variable project {
  description = "Project ID"
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

variable disk_image {
  description = "Disk image"
}

variable users {
  description = "List of users to add ssh-keys"
  type        = "list"
}

variable app_count {
  description = "Reddit app instances count"
  default     = "1"
}
