output "app_lb_ip" {
  value = "${google_compute_global_address.applbaddress.address}"
}
