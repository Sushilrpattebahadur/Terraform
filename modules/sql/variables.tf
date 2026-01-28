variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "instance_name" {
  description = "Cloud SQL Instance name"
  type        = string
}

variable "database_version" {
  description = "Database version (e.g., POSTGRES_15)"
  type        = string
  default     = "POSTGRES_15"
}

variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the instance"
  type        = string
  default     = "db-g1-small"
}

variable "disk_type" {
  description = "Disk type (PD_SSD or PD_HDD)"
  type        = string
  default     = "PD_SSD"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "availability_type" {
  description = "Availability type (REGIONAL or ZONAL)"
  type        = string
  default     = "REGIONAL"
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "private_network_id" {
  description = "VPC Network ID for private IP"
  type        = string
}

variable "charset" {
  description = "Character set for the database"
  type        = string
  default     = "UTF8"
}

variable "iam_user_email" {
  description = "IAM user email for Cloud SQL access"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "service_account_id" {
  description = "Service account ID"
  type        = string
}

variable "labels" {
  description = "Labels for the instance"
  type        = map(string)
  default     = {}
}
