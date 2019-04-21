output "appserver" {
  value = "${module.app.app_external_ip}"
}

output "dbserver" {
  value = "${module.db.db_external_ip}"
}
