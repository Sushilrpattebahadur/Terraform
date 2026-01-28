output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "VPC Network ID"
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "VPC Network Name"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet.id
  description = "Subnet ID"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Subnet Name"
}

output "subnet_cidr" {
  value       = google_compute_subnetwork.subnet.ip_cidr_range
  description = "Subnet CIDR range"
}

output "router_id" {
  value       = google_compute_router.router.id
  description = "Cloud Router ID"
}

output "nat_id" {
  value       = google_compute_router_nat.nat.id
  description = "Cloud NAT ID"
}
