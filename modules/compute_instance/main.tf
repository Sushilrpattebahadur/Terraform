terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Compute Engine Instance
resource "google_compute_instance" "app_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {
      nat_ip = var.enable_external_ip ? google_compute_address.static_ip[0].address : null
    }
  }

  service_account {
    email  = google_service_account.compute_sa.email
    scopes = var.service_account_scopes
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = var.startup_script

  tags = concat(var.tags, ["compute-instance"])

  labels = var.labels

  allow_stopping_for_update = true
}

# Static IP Address (optional)
resource "google_compute_address" "static_ip" {
  count   = var.enable_external_ip ? 1 : 0
  name    = "${var.instance_name}-static-ip"
  region  = var.region
  project = var.project_id
}

# Service Account
resource "google_service_account" "compute_sa" {
  account_id   = var.service_account_id
  display_name = "Service Account for ${var.instance_name}"
  project      = var.project_id
}

# IAM Roles
resource "google_project_iam_member" "compute_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.compute_sa.email}"
}

resource "google_project_iam_member" "compute_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.compute_sa.email}"
}
