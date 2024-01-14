resource "aws_nat_gateway" "eks_nat" {
    subnet_id = aws_subnet.public_subnets[0].id
    allocation_id = aws_eip.eks_eip.allocation_id    
}

# Elastic IP without instance
resource "aws_eip" "eks_eip" {
  # No need to specify "instance" here
}