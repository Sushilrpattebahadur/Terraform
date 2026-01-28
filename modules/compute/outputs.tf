output "instance_name" {
  value       = google_sql_database_instance.main.name
  description = "The name of the Cloud SQL instance"
}

output "instance_connection_name" {
  value       = google_sql_database_instance.main.connection_name
  description = "The connection name of the instance"
}

output "instance_self_link" {
  value       = google_sql_database_instance.main.self_link
  description = "The self link of the instance"
}

output "private_ip_address" {
  value       = google_sql_database_instance.main.private_ip_address
  description = "The private IP address of the instance"
}

output "public_ip_address" {
  value       = google_sql_database_instance.main.public_ip_address
  description = "The public IP address of the instance"
}

output "database_name" {
  value       = google_sql_database.database.name
  description = "The name of the database"
}

output "service_account_email" {
  value       = google_service_account.sql_sa.email
  description = "Email of the Cloud SQL service account"
}
