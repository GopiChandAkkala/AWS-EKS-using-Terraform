resource "aws_security_group" "node_sg" {
    vpc_id = var.eks_vpc_id
    name = "EKS-nodes-SG"

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  } 
    
}

resource "aws_security_group_rule" "nodes" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.node_sg.id
  to_port = 65535
  type = "ingress"
  source_security_group_id = aws_security_group.node_sg.id  
}

resource "aws_security_group_rule" "nodes_inbound" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.node_sg.id
  to_port = 65535
  type = "ingress"
  source_security_group_id = aws_security_group.controlplane_sg.id
}