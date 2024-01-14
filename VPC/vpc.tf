resource "aws_vpc" "eks-vpc" {
    cidr_block = var.vpc_cidr_block
     # Your VPC must have DNS hostname and DNS resolution support. 
     # If not the worker nodes cannot register with the cluster
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
    Name = "EKS-VPC-Project"
  }  
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
      Name = "EKS-VPC-Project-InternetGateway"
    }
  
}