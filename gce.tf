resource "google_compute_instance" "tf-vm-instances" {
  for_each = var.instances
  name = each.key
  machine_type = each.value.machine_type 
  zone = each.value.zone
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size = each.value.disk_size
      type = "pd-standard"
    }
  }
  network_interface {
    network =  google_compute_network.chathura-network.self_link
    subnetwork = each.value.subnet
  }
}


data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"   
  project = "ubuntu-os-cloud"
}