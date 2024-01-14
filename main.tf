module "eks" {
    source = "./EKS"
    eks_subnets_id = module.vpc.public_subnets
    eks_vpc_id = module.vpc.vpv_id
  
}

module "vpc" {
    source = "./VPC"
  
}