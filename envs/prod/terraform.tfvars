project_id = "yt-automation-347812"
region     = "asia-south1"

# Network
network_name  = "gcp-app-vpc-prod"
subnet_name   = "gcp-app-subnet-prod"
subnet_cidr   = "10.1.0.0/24"
pods_cidr     = "10.4.0.0/14"
services_cidr = "10.1.16.0/20"

# GKE
cluster_name           = "gcp-app-gke-prod"
kubernetes_version     = "1.27"
initial_node_count     = 3
min_node_count         = 3
max_node_count         = 10
gke_machine_type       = "n1-standard-4"
disk_size_gb           = 100
preemptible            = false
enable_network_policy  = true

# Storage
storage_bucket_name       = "gcp-app-storage-prod-${RANDOM_SUFFIX}"
enable_storage_versioning = true
storage_delete_after_days = 365

# Database
sql_instance_name = "gcp-app-db-prod"
database_name     = "appdb"
database_version  = "POSTGRES_15"
sql_machine_type  = "db-n1-standard-2"
sql_disk_size     = 100
iam_user_email    = "YOUR_IAM_USER@example.com"
db_username       = "app_user"
