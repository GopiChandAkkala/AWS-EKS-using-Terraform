variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "azs" {
    type = list(string)
    default = ["us-east-1a","us-east-1b"]  
}

variable "public_subnet_cidr" {
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]  
}

variable "private_subnet_cidr" {
    default = ["10.0.3.0/24", "10.0.4.0/24"]  
}