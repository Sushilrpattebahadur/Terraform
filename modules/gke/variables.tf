variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the GKE cluster"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
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

variable "pods_secondary_range_name" {
  description = "Secondary IP range name for pods"
  type        = string
  default     = "pods"
}

variable "services_secondary_range_name" {
  description = "Secondary IP range name for services"
  type        = string
  default     = "services"
}

variable "kubernetes_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "initial_node_count" {
  description = "Initial number of nodes in the node pool"
  type        = number
  default     = 3
}

variable "min_node_count" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes"
  type        = number
  default     = 5
}

variable "machine_type" {
  description = "The machine type for nodes"
  type        = string
  default     = "n1-standard-2"
}

variable "disk_size_gb" {
  description = "Disk size in GB for nodes"
  type        = number
  default     = 50
}

variable "preemptible" {
  description = "Whether to use preemptible nodes"
  type        = bool
  default     = false
}

variable "enable_network_policy" {
  description = "Enable network policy"
  type        = bool
  default     = true
}

variable "binary_authorization_mode" {
  description = "Binary authorization evaluation mode"
  type        = string
  default     = "EVALUATION_MODE_UNSPECIFIED"
}

variable "node_labels" {
  description = "Labels to apply to nodes"
  type        = map(string)
  default     = {}
}

variable "node_tags" {
  description = "Tags to apply to nodes"
  type        = list(string)
  default     = []
}

variable "resource_labels" {
  description = "Labels to apply to GKE resources"
  type        = map(string)
  default     = {}
}
