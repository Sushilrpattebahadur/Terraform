terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }

  backend "gcs" {
    bucket = "gcp-terraform-state-staging"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  project_id                    = var.project_id
  region                        = var.region
  network_name                  = var.network_name
  subnet_name                   = var.subnet_name
  subnet_cidr                   = var.subnet_cidr
  pods_cidr                     = var.pods_cidr
  services_cidr                 = var.services_cidr
  pods_secondary_range_name     = var.pods_secondary_range_name
  services_secondary_range_name = var.services_secondary_range_name
  allowed_ssh_ranges            = var.allowed_ssh_ranges
}

module "gke" {
  source = "../../modules/gke"

  project_id                    = var.project_id
  region                        = var.region
  cluster_name                  = var.cluster_name
  network_name                  = module.vpc.vpc_name
  subnet_name                   = module.vpc.subnet_name
  kubernetes_version            = var.kubernetes_version
  initial_node_count            = var.initial_node_count
  min_node_count                = var.min_node_count
  max_node_count                = var.max_node_count
  machine_type                  = var.gke_machine_type
  disk_size_gb                  = var.disk_size_gb
  preemptible                   = var.preemptible
  enable_network_policy         = var.enable_network_policy
  pods_secondary_range_name     = var.pods_secondary_range_name
  services_secondary_range_name = var.services_secondary_range_name
  node_labels                   = var.node_labels
  resource_labels               = var.resource_labels

  depends_on = [module.vpc]
}

module "storage" {
  source = "../../modules/storage"

  project_id          = var.project_id
  bucket_name         = var.storage_bucket_name
  location            = var.region
  service_account_id  = "${var.cluster_name}-storage-sa"
  enable_versioning   = var.enable_storage_versioning
  delete_after_days   = var.storage_delete_after_days
  labels              = var.resource_labels
}

module "sql" {
  source = "../../modules/sql"

  project_id           = var.project_id
  region               = var.region
  instance_name        = var.sql_instance_name
  database_name        = var.database_name
  database_version     = var.database_version
  machine_type         = var.sql_machine_type
  disk_size            = var.sql_disk_size
  private_network_id   = module.vpc.vpc_id
  iam_user_email       = var.iam_user_email
  db_username          = var.db_username
  service_account_id   = "${var.cluster_name}-sql-sa"
  labels               = var.resource_labels
}
