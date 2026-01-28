output "instance_name" {
  value       = google_sql_database_instance.postgres.name
  description = "Cloud SQL instance name"
}

output "instance_connection_name" {
  value       = google_sql_database_instance.postgres.connection_name
  description = "Connection name for Cloud SQL"
}

output "instance_self_link" {
  value       = google_sql_database_instance.postgres.self_link
  description = "Self link of the instance"
}

output "private_ip_address" {
  value       = google_sql_database_instance.postgres.private_ip_address
  description = "Private IP address"
  sensitive   = true
}

output "database_name" {
  value       = google_sql_database.db.name
  description = "Database name"
}

output "db_user" {
  value       = google_sql_user.db_user.name
  description = "Database username"
}

output "db_password" {
  value       = random_password.db_password.result
  description = "Database password"
  sensitive   = true
}

output "service_account_email" {
  value       = google_service_account.sql_sa.email
  description = "Service account email"
}
