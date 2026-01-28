variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "pods_cidr" {
  description = "CIDR range for pods"
  type        = string
  default     = "10.4.0.0/14"
}

variable "services_cidr" {
  description = "CIDR range for services"
  type        = string
  default     = "10.0.16.0/20"
}

variable "pods_secondary_range_name" {
  description = "Name of the pods secondary IP range"
  type        = string
  default     = "pods"
}

variable "services_secondary_range_name" {
  description = "Name of the services secondary IP range"
  type        = string
  default     = "services"
}

variable "routing_mode" {
  description = "The network routing mode"
  type        = string
  default     = "REGIONAL"
}

variable "allowed_ssh_ranges" {
  description = "IP ranges allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
