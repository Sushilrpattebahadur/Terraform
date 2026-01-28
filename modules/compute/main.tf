terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Cloud SQL Instance
resource "google_sql_database_instance" "main" {
  name                = var.instance_name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection
  project             = var.project_id

  settings {
    tier              = var.machine_type
    availability_type = var.availability_type
    disk_type         = var.disk_type
    disk_size         = var.disk_size

    backup_configuration {
      enabled                        = true
      start_time                     = "03:00"
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 7
      binary_log_enabled             = true
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private_network

      authorized_networks {
        name  = "allow-gke"
        value = var.authorized_network_cidr
      }
    }

    database_flags {
      name  = "cloudsql_iam_authentication"
      value = "on"
    }

    user_labels = var.labels
  }

  depends_on = [var.depends_on]
}

# Database
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.main.name
  project  = var.project_id
}

# Database User with IAM Authentication
resource "google_sql_user" "iam_user" {
  name     = var.iam_user_email
  instance = google_sql_database_instance.main.name
  type     = "CLOUD_IAM_USER"
  project  = var.project_id
}

# Service Account for Cloud SQL Access
resource "google_service_account" "sql_sa" {
  account_id   = var.service_account_id
  display_name = "Service Account for Cloud SQL"
  project      = var.project_id
}

# IAM Role for SQL Client
resource "google_project_iam_member" "sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.sql_sa.email}"
}
