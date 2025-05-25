variable "region" {
  default = "us-east-2"
}

# core VPC paramters 
variable "web_app_cidr" {
  default = "10.10.0.0/16"
}

# public subnets
variable "public_subnet_a_cidr" {
  default = "10.10.1.0/24"
}