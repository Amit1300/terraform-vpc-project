variable "vpc_cidr" {
    description = "vpc cidr value"
    type = string 
}

variable "subnet_cidr" {
    description = "cidr of subnets"
    type=list(string)
  
}

