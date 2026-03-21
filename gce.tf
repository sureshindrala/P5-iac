# Generate a SSH Keypair
# this will generate public and private keys
resource "tls_private_key" "chathura-key" {
  algorithm = "RSA"
  rsa_bits = 2048
}

# Save the private key to local file 
resource "local_file" "chathura-key-private" {
  content = tls_private_key.chathura-key.private_key_pem
  filename = "${path.module}/id_rsa"
}

# Save the public key to local file

resource "local_file" "chathura-key-pub" {
  content = tls_private_key.chathura-key.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}


# Create virtula machine

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
    access_config {
      
    }
  }
  # belos is to place the public key inside the gce vm 
  metadata = {
    ssh-keys = "${var.vm_user}:${tls_private_key.chathura-key.public_key_openssh}"
  }

    # Connection block to connect to the instances 
  connection {
    host = self.network_interface[0].access_config[0].nat_ip
    type = "ssh" # winrm
    user = var.vm_user
    #password = *****
    private_key = tls_private_key.chathura-key.private_key_pem
  }
  provisioner "file" {
    source = each.key == "ansible" ? "ansible.sh" : "empty.sh"
    destination = each.key == "ansible" ? "/home/${var.vm_user}/ansible.sh" : "/home/${var.vm_user}/empty.sh"
  }
        # Provisioner block to execute on the remote machine
  provisioner "remote-exec" {
    inline = [ 
      each.key == "ansible" ? "chmod +x /home/${var.vm_user}/ansible.sh && /home/${var.vm_user}/ansible.sh" : "echo 'Not an Ansible Instance'"
     ]
  }

    # File proviosner to copy private key to all the vms
  provisioner "file" {
    source = "${path.module}/id_rsa"
    destination = "/home/${var.vm_user}/ssh-key"
  }

}


data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"   
  project = "ubuntu-os-cloud"
}