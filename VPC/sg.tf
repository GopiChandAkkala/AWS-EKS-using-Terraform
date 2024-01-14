resource "aws_security_group" "public_sg" {
    vpc_id = aws_vpc.eks-vpc.id
    name = "EKS-Public-SG"

    ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] 
    } 

    ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
    
}

