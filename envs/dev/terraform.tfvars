project_id = "yt-automation-347812"
region     = "asia-south1"

# Network
network_name  = "gcp-app-vpc-dev"
subnet_name   = "gcp-app-subnet-dev"
subnet_cidr   = "10.0.0.0/24"
pods_cidr     = "10.4.0.0/14"
services_cidr = "10.0.16.0/20"

# GKE
cluster_name           = "gcp-app-gke-dev"
kubernetes_version     = "1.27"
initial_node_count     = 2
min_node_count         = 1
max_node_count         = 3
gke_machine_type       = "n1-standard-2"
disk_size_gb           = 50
preemptible            = true
enable_network_policy  = true

# Storage
storage_bucket_name       = "gcp-app-storage-dev-${RANDOM_SUFFIX}"
enable_storage_versioning = true
storage_delete_after_days = 90

# Database
sql_instance_name = "gcp-app-db-dev"
database_name     = "appdb"
database_version  = "POSTGRES_15"
sql_machine_type  = "db-g1-small"
sql_disk_size     = 20
iam_user_email    = "YOUR_IAM_USER@example.com"
db_username       = "app_user"
