output "gke_cluster_name" {
  value       = module.gke.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "gke_cluster_host" {
  value       = module.gke.kubernetes_cluster_host
  description = "GKE Cluster Host"
  sensitive   = true
}

output "region" {
  value       = var.region
  description = "GCP Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCP Project ID"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "subnet_id" {
  value       = module.vpc.subnet_id
  description = "Subnet ID"
}

output "storage_bucket_name" {
  value       = module.storage.bucket_name
  description = "Cloud Storage Bucket Name"
}

output "sql_instance_name" {
  value       = module.sql.instance_name
  description = "Cloud SQL Instance Name"
}

output "sql_connection_name" {
  value       = module.sql.instance_connection_name
  description = "Cloud SQL Connection Name"
}
