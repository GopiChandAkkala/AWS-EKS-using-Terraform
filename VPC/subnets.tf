resource "aws_subnet" "public_subnets" {
    vpc_id = aws_vpc.eks-vpc.id
    count = length(var.public_subnet_cidr)
    cidr_block = element(var.public_subnet_cidr,count.index)
    availability_zone = element(var.azs,count.index)
    map_public_ip_on_launch = true  

    tags = {
      Name = "Public-Subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private_subnets" {
    vpc_id = aws_vpc.eks-vpc.id
    count = length(var.private_subnet_cidr)
    cidr_block = element(var.private_subnet_cidr,count.index)
    availability_zone = element(var.azs,count.index)

    tags = {
      Name = "Private-Subnet-${count.index + 1}"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.eks-vpc.id

    route {
       cidr_block = "0.0.0.0/0"
       gateway_id = aws_internet_gateway.vpc-igw.id
    }

    tags = {
      Name = "Public Subnets Route Table"
    }    
}

resource "aws_route_table_association" "public_route_assoc" {
    route_table_id = aws_route_table.public_route_table.id
    count = length(var.public_subnet_cidr)
    subnet_id = aws_subnet.public_subnets[count.index].id    
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.eks-vpc.id

    route {      
      cidr_block = "0.0.0.0/0"   
      nat_gateway_id = aws_nat_gateway.eks_nat.id            
    } 

     tags = {
      Name = "Private Subnets Route Table"
    } 
}

resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.private_route_table.id
    count = length(var.private_subnet_cidr)
    subnet_id = aws_subnet.private_subnets[count.index].id    
    
}