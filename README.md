# GCP Terraform Project for Kubernetes Application

## Project Overview

This Terraform project provides a complete Infrastructure as Code (IaC) solution for deploying a GCP application on Google Kubernetes Engine (GKE). It includes all necessary components for a production-ready Kubernetes infrastructure.

## Project Structure

```
terraform/
├── envs/
│   ├── dev/              # Development environment
│   ├── prod/             # Production environment
│   └── staging/          # Staging environment
├── modules/
│   ├── vpc/              # VPC network and subnet configuration
│   ├── gke/              # Google Kubernetes Engine cluster
│   ├── storage/          # Cloud Storage buckets
│   ├── sql/              # Cloud SQL database
│   ├── compute/          # Cloud SQL configuration
│   └── compute_instance/ # Compute Engine instances
└── README.md
```

## Modules

### VPC Module (`modules/vpc/`)
- Creates a VPC network with custom subnets
- Configures secondary IP ranges for pods and services
- Sets up Cloud Router and Cloud NAT for outbound connectivity
- Defines firewall rules for internal, SSH, and HTTP/HTTPS traffic

**Key Resources:**
- Google Compute Network
- Google Compute Subnetwork
- Cloud Router and NAT
- Firewall Rules

### GKE Module (`modules/gke/`)
- Deploys a fully managed Google Kubernetes Engine cluster
- Configures node pools with auto-scaling capabilities
- Enables workload identity for secure service account integration
- Implements network policies for pod-level security
- Sets up monitoring and logging

**Key Resources:**
- Google Container Cluster
- Google Container Node Pool
- Service Accounts with IAM roles
- Kubernetes Provider configuration

### Storage Module (`modules/storage/`)
- Creates Cloud Storage buckets for application data
- Enables versioning and lifecycle policies
- Configures service accounts for bucket access
- Implements IAM roles for secure access control

**Key Resources:**
- Google Storage Bucket
- Service Account
- Storage IAM Bindings

### SQL Module (`modules/sql/`)
- Deploys Cloud SQL instances (PostgreSQL)
- Configures private networking for database access
- Sets up IAM-based authentication
- Implements backup and recovery policies

**Key Resources:**
- Cloud SQL Database Instance
- Database and users
- Service Account with SQL access roles

### Compute Module (`modules/compute/`)
- Creates Cloud SQL instances for database workloads
- Configures database users and IAM authentication
- Sets up backup and recovery policies
- Implements monitoring and logging

### Compute Instance Module (`modules/compute_instance/`)
- Deploys Compute Engine instances
- Configures static IP addresses (optional)
- Sets up service accounts with appropriate scopes
- Includes OS Login and security configurations

## Environments

### Development (`envs/dev/`)
- Uses preemptible nodes for cost optimization
- Smaller resource allocation (2-3 nodes, n1-standard-2)
- Relaxed SSH access policies
- Suitable for testing and development

### Production (`envs/prod/`)
- Standard (non-preemptible) nodes for reliability
- Larger resource allocation (3-10 nodes, n1-standard-4)
- Enhanced security with restricted SSH access
- Optimized for high availability and performance

### Staging (`envs/staging/`)
- Middle ground between dev and prod
- 2-5 nodes with n1-standard-2 machines
- Standard (non-preemptible) nodes
- Balanced resource allocation

## Prerequisites

1. **GCP Project**: Create a GCP project and note the project ID
2. **Terraform**: Version 1.0 or higher
3. **Google Cloud SDK**: For authentication and additional configurations
4. **Service Account**: Create a service account with appropriate permissions:
   - Kubernetes Engine Admin
   - Compute Admin
   - Database Admin
   - Storage Admin
   - Service Account Admin
   - Network Admin

## Authentication

```bash
# Option 1: Using Google Cloud SDK
gcloud auth application-default login

# Option 2: Using service account key
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account-key.json
```

## Usage

### Initialize Terraform

```bash
cd envs/dev  # or prod/staging
terraform init
```

### Plan Deployment

```bash
# Review planned changes
terraform plan -var-file=terraform.tfvars

# Save plan to file
terraform plan -var-file=terraform.tfvars -out=tfplan
```

### Apply Configuration

```bash
# Apply the configuration
terraform apply tfplan

# Or apply directly (requires confirmation)
terraform apply -var-file=terraform.tfvars
```

### View Outputs

```bash
# Display all outputs
terraform output

# Get specific output
terraform output gke_cluster_name
```

### Destroy Infrastructure

```bash
# Destroy resources (requires confirmation)
terraform destroy -var-file=terraform.tfvars
```

## Configuration

### Update terraform.tfvars

Each environment has a `terraform.tfvars` file with environment-specific configurations:

```hcl
project_id = "YOUR_PROJECT_ID"
region     = "us-central1"

# Network
network_name  = "gcp-app-vpc-dev"
subnet_name   = "gcp-app-subnet-dev"

# GKE
cluster_name       = "gcp-app-gke-dev"
initial_node_count = 2
```

### Custom Variables

You can override variables at runtime:

```bash
terraform apply \
  -var="project_id=my-project" \
  -var="region=us-west1" \
  -var="initial_node_count=4"
```

## Outputs

Common outputs available after deployment:

- `gke_cluster_name`: Name of the GKE cluster
- `gke_cluster_host`: Kubernetes API endpoint
- `storage_bucket_name`: Cloud Storage bucket name
- `sql_instance_name`: Cloud SQL instance name
- `sql_connection_name`: SQL connection string

## Security Best Practices

1. **Network Security**:
   - Private subnets for database and cache resources
   - Network policies enabled on GKE
   - VPC peering for inter-cluster communication

2. **IAM Security**:
   - Service accounts with least privilege
   - Workload identity for pod authentication
   - IAM binding for controlled access

3. **Data Protection**:
   - Encryption at rest (Cloud SQL)
   - TLS for data in transit
   - Versioning enabled for storage buckets

4. **Access Control**:
   - OS Login enabled on Compute instances
   - SSH key management through Google Cloud Console
   - Database user isolation

## Monitoring and Logging

- Cloud Logging integrated with GKE
- Cloud Monitoring for metrics and alerts
- Query Insights enabled on Cloud SQL
- Application-level logging recommended

## Cost Optimization

- **Development**: Uses preemptible nodes (70% cost savings)
- **Staging**: Standard nodes with moderate sizing
- **Production**: Standard nodes with auto-scaling
- Cloud Storage lifecycle policies for automatic archiving

## Troubleshooting

### Common Issues

1. **Authentication Error**:
   ```bash
   gcloud auth application-default login
   terraform init
   ```

2. **Quota Exceeded**:
   Check GCP quotas and request increases in Cloud Console

3. **Network Issues**:
   Verify VPC and firewall rule configuration
   Check GCP console for IP allocation status

## Additional Resources

- [Terraform GCP Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Google Kubernetes Engine Documentation](https://cloud.google.com/kubernetes-engine/docs)
- [Cloud SQL Documentation](https://cloud.google.com/sql/docs)
- [VPC Network Documentation](https://cloud.google.com/vpc/docs)

## Contributing

When making changes to this infrastructure:

1. Create a new branch
2. Make changes to the appropriate modules
3. Run `terraform plan` to review changes
4. Test in a non-production environment first
5. Document significant changes

## License

This project is provided as-is for use with GCP infrastructure deployment.

## Support

For issues or questions:
1. Check GCP console for resource status
2. Review Terraform state files
3. Check Cloud Logging for error messages
4. Verify service account permissions
