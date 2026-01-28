terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Cloud Storage Bucket
resource "google_storage_bucket" "app_bucket" {
  name          = var.bucket_name
  location      = var.location
  project       = var.project_id
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = var.enable_versioning
  }

  lifecycle_rule {
    condition {
      age = var.delete_after_days
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      num_newer_versions = var.keep_versions
    }
    action {
      type = "Delete"
    }
  }

  labels = var.labels
}

# Service Account for Cloud Storage Access
resource "google_service_account" "storage_sa" {
  account_id   = var.service_account_id
  display_name = "Service Account for ${var.bucket_name}"
  project      = var.project_id
}

# IAM Binding for Storage Bucket
resource "google_storage_bucket_iam_member" "bucket_access" {
  bucket = google_storage_bucket.app_bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.storage_sa.email}"
}

resource "google_storage_bucket_iam_member" "bucket_admin" {
  bucket = google_storage_bucket.app_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.storage_sa.email}"
}
