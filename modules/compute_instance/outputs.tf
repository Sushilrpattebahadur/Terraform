output "instance_id" {
  value       = google_compute_instance.app_instance.id
  description = "Instance ID"
}

output "instance_name" {
  value       = google_compute_instance.app_instance.name
  description = "Instance name"
}

output "instance_self_link" {
  value       = google_compute_instance.app_instance.self_link
  description = "Self link of the instance"
}

output "internal_ip" {
  value       = google_compute_instance.app_instance.network_interface[0].network_ip
  description = "Internal IP address"
}

output "external_ip" {
  value       = var.enable_external_ip ? google_compute_address.static_ip[0].address : null
  description = "External IP address"
}

output "service_account_email" {
  value       = google_service_account.compute_sa.email
  description = "Service account email"
}
