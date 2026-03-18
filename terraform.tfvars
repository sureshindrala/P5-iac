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