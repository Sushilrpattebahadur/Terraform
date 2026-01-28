project_id = "yt-automation-347812"
region     = "asia-south1"

# Network
network_name  = "gcp-app-vpc-staging"
subnet_name   = "gcp-app-subnet-staging"
subnet_cidr   = "10.2.0.0/24"
pods_cidr     = "10.4.0.0/14"
services_cidr = "10.2.16.0/20"

# GKE
cluster_name           = "gcp-app-gke-staging"
kubernetes_version     = "1.27"
initial_node_count     = 2
min_node_count         = 2
max_node_count         = 5
gke_machine_type       = "n1-standard-2"
disk_size_gb           = 50
preemptible            = false
enable_network_policy  = true

# Storage
storage_bucket_name       = "gcp-app-storage-staging-${RANDOM_SUFFIX}"
enable_storage_versioning = true
storage_delete_after_days = 180

# Database
sql_instance_name = "gcp-app-db-staging"
database_name     = "appdb"
database_version  = "POSTGRES_15"
sql_machine_type  = "db-g1-small"
sql_disk_size     = 50
iam_user_email    = "YOUR_IAM_USER@example.com"
db_username       = "app_user"
