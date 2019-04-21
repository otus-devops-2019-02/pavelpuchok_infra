resource "google_compute_instance_group" "appgroup" {
  name = "reddit-app-group"
  zone = "europe-west1-b"

  instances = ["${google_compute_instance.app.*.self_link}"]

  named_port {
    name = "http"
    port = "9292"
  }
}

resource "google_compute_backend_service" "appbackend" {
  name = "reddit-app-backend"

  backend {
    group = "${google_compute_instance_group.appgroup.self_link}"
  }

  health_checks = [
    "${google_compute_http_health_check.apphealthcheck.self_link}",
  ]
}

resource "google_compute_http_health_check" "apphealthcheck" {
  name = "reddit-app-health-check"
  port = "9292"
}

resource "google_compute_url_map" "appurlmap" {
  name            = "reddit-app-url-map"
  default_service = "${google_compute_backend_service.appbackend.self_link}"
}

resource "google_compute_target_http_proxy" "apphttpproxy" {
  name    = "reddit-app-proxy"
  url_map = "${google_compute_url_map.appurlmap.self_link}"
}

resource "google_compute_global_address" "applbaddress" {
  name = "reddit-app-lb-address"
}

resource "google_compute_global_forwarding_rule" "applbforwardingrule" {
  name       = "reddit-app-lb-forwarding-rule"
  target     = "${google_compute_target_http_proxy.apphttpproxy.self_link}"
  ip_address = "${google_compute_global_address.applbaddress.address}"
  port_range = "80"
}
