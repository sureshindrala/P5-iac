#********************chathura end to end project *******************************

# ***********VPC detaials*************************
vpc_name = "chathura-vpc"

subnets = [ {
  name = "subnet1"
  ip_cidr_range = "10.1.0.0/16"
  subnet_region = "us-central1"  
    },
    {
  name = "subnet2"
  ip_cidr_range = "10.2.0.0/16"
  subnet_region = "us-east1"         
    }

]
# instance details
instances = {
    "ansible" = {
        machine_type = "e2-medium"
        zone = "us-central1-a"
        subnet = "projects/project-0070602e-2c4e-4f42-a69/regions/us-central1/subnetworks/subnet1"
        disk_size = "10"
    
  },
    "jenkins-master" = {
         machine_type = "e2-medium"
         zone = "us-east1-c"
         subnet = "projects/project-0070602e-2c4e-4f42-a69/regions/us-east1/subnetworks/subnet2"
         disk_size = "10" 
  },
    "jenkins-slave" = {
        machine_type = "e2-medium"
         zone = "us-east1-c"
         subnet = "projects/project-0070602e-2c4e-4f42-a69/regions/us-east1/subnetworks/subnet2"
         disk_size = "30"
    }
}

# vm user name
vm_user = "suresh"

# Source range
source_ranges = [ "0.0.0.0/0" ]





#"projects/project-0070602e-2c4e-4f42-a69/regions/us-east1/subnetworks/subnet2"