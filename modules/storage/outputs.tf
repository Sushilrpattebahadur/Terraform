output "bucket_name" {
  value       = google_storage_bucket.app_bucket.name
  description = "The name of the Cloud Storage bucket"
}

output "bucket_url" {
  value       = google_storage_bucket.app_bucket.url
  description = "The URL of the Cloud Storage bucket"
}

output "service_account_email" {
  value       = google_service_account.storage_sa.email
  description = "Email of the storage service account"
}

output "service_account_id" {
  value       = google_service_account.storage_sa.unique_id
  description = "Unique ID of the storage service account"
}
