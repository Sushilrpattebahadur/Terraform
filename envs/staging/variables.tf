# Provider Configuration
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

# Network Configuration
variable "network_name" {
  description = "VPC Network name"
  type        = string
  default     = "gcp-app-vpc-staging"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "gcp-app-subnet-staging"
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.2.0.0/24"
}

variable "pods_cidr" {
  description = "Pods secondary CIDR"
  type        = string
  default     = "10.4.0.0/14"
}

variable "services_cidr" {
  description = "Services secondary CIDR"
  type        = string
  default     = "10.2.16.0/20"
}

variable "pods_secondary_range_name" {
  description = "Pods secondary range name"
  type        = string
  default     = "pods"
}

variable "services_secondary_range_name" {
  description = "Services secondary range name"
  type        = string
  default     = "services"
}

variable "allowed_ssh_ranges" {
  description = "Allowed SSH ranges"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

# GKE Configuration
variable "cluster_name" {
  description = "GKE Cluster name"
  type        = string
  default     = "gcp-app-gke-staging"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "initial_node_count" {
  description = "Initial number of nodes"
  type        = number
  default     = 2
}

variable "min_node_count" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2
}

variable "max_node_count" {
  description = "Maximum number of nodes"
  type        = number
  default     = 5
}

variable "gke_machine_type" {
  description = "GKE node machine type"
  type        = string
  default     = "n1-standard-2"
}

variable "disk_size_gb" {
  description = "Node disk size in GB"
  type        = number
  default     = 50
}

variable "preemptible" {
  description = "Use preemptible nodes"
  type        = bool
  default     = false
}

variable "enable_network_policy" {
  description = "Enable network policy"
  type        = bool
  default     = true
}

variable "node_labels" {
  description = "Labels for nodes"
  type        = map(string)
  default = {
    environment = "staging"
    managed-by  = "terraform"
  }
}

# Storage Configuration
variable "storage_bucket_name" {
  description = "Cloud Storage bucket name"
  type        = string
  default     = "gcp-app-storage-staging"
}

variable "enable_storage_versioning" {
  description = "Enable storage versioning"
  type        = bool
  default     = true
}

variable "storage_delete_after_days" {
  description = "Delete storage objects after days"
  type        = number
  default     = 180
}

# Database Configuration
variable "sql_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "gcp-app-db-staging"
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "database_version" {
  description = "Database version"
  type        = string
  default     = "POSTGRES_15"
}

variable "sql_machine_type" {
  description = "SQL machine type"
  type        = string
  default     = "db-g1-small"
}

variable "sql_disk_size" {
  description = "SQL disk size in GB"
  type        = number
  default     = 50
}

variable "iam_user_email" {
  description = "IAM user email for SQL access"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "app_user"
}

# Labels
variable "resource_labels" {
  description = "Labels for all resources"
  type        = map(string)
  default = {
    environment = "staging"
    managed-by  = "terraform"
    application = "gcp-app"
  }
}
