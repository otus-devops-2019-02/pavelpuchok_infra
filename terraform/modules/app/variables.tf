variable app_count {
  description = "Reddit app instances count"
  default     = "1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "App Disk image"
  default     = "reddit-app-base"
}
