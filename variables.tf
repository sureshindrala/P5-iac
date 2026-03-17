variable "vpc_name" {
    description = "network_name"
    type = "string"
}
variable "subnets" {
    description = "creating sunets"
    type = list(object({
        name = string
        ip_cidr_range = string
        subnet_region = string
    }))
}
  

  
