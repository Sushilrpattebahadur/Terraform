terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Cloud SQL Instance for PostgreSQL
resource "google_sql_database_instance" "postgres" {
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
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private_network_id
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = 1024
      record_application_tags = true
      record_client_address   = true
    }

    user_labels = var.labels
  }
}

# Database
resource "google_sql_database" "db" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres.name
  project  = var.project_id
  charset  = var.charset
}

# Database User (IAM-based)
resource "google_sql_user" "iam_user" {
  name     = var.iam_user_email
  instance = google_sql_database_instance.postgres.name
  type     = "CLOUD_IAM_USER"
  project  = var.project_id
}

# Database User (Password-based)
resource "random_password" "db_password" {
  length  = 32
  special = true
}

resource "google_sql_user" "db_user" {
  name     = var.db_username
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_password.result
  project  = var.project_id
}

# Service Account for Cloud SQL
resource "google_service_account" "sql_sa" {
  account_id   = var.service_account_id
  display_name = "Cloud SQL Service Account"
  project      = var.project_id
}

# IAM Role Binding
resource "google_project_iam_member" "sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.sql_sa.email}"
}

resource "google_project_iam_member" "sql_instance_user" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.sql_sa.email}"
}
