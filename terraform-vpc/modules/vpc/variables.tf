variable "vpc_cidr" {
    description = "vpc cidr value"
    type = string 
}

variable "subnet_cidr" {
    description = "cidr of subnets"
    type=list(string)
  
}


variable "subnet_names" {
  
  type=list(string)
  default=["publicsubnet_1","publicsubnet_2"]
}