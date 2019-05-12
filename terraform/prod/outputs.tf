output "appserver" {
  value = "${module.app.app_external_ip}"
}

output "dbserver" {
  value = "${module.db.db_external_ip}"
}

output "dbserver_internal" {
  value = "${module.db.db_internal_ip}"
}
