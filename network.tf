resource "google_compute_network" "chathura-network" {
    name = var.vpc_name
    auto_create_subnetworks = false
    
}

# subnet creation for vpc 
resource "google_compute_subnetwork" "subnet" {
    count = length(var.subnets)
    name = var.subnets[count.index].name
    ip_cidr_range = var.subnets[count.index].ip_cidr_range
    region = var.subnets[count.index].subnet_region
    network = google_compute_network.chathura-network.self_link
    
}



