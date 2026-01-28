variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "The database version (e.g., POSTGRES_15, MYSQL_8_0)"
  type        = string
  default     = "POSTGRES_15"
}

variable "machine_type" {
  description = "The machine type for the instance"
  type        = string
  default     = "db-g1-small"
}

variable "disk_type" {
  description = "The disk type (PD_SSD or PD_HDD)"
  type        = string
  default     = "PD_SSD"
}

variable "disk_size" {
  description = "The disk size in GB"
  type        = number
  default     = 20
}

variable "availability_type" {
  description = "The availability type (REGIONAL or ZONAL)"
  type        = string
  default     = "REGIONAL"
}

variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "The VPC network for private IP"
  type        = string
}

variable "authorized_network_cidr" {
  description = "Authorized network CIDR for SQL access"
  type        = string
}

variable "iam_user_email" {
  description = "Email of the IAM user for Cloud SQL"
  type        = string
}

variable "service_account_id" {
  description = "The service account ID for Cloud SQL access"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the instance"
  type        = map(string)
  default     = {}
}

variable "depends_on" {
  description = "Explicit dependencies"
  type        = list(any)
  default     = []
}
