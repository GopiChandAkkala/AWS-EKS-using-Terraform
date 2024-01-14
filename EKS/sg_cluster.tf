resource "aws_security_group" "controlplane_sg" {
    vpc_id = var.eks_vpc_id
    name = "EKS-controlplane-SG"
    description = "Cluster communication with worker nodes"
}

resource "aws_security_group_rule" "cluster_inbound" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.controlplane_sg.id
  to_port = 0
  type = "ingress"  
  source_security_group_id = aws_security_group.node_sg.id
}

resource "aws_security_group_rule" "cluster_outbound" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.controlplane_sg.id
  to_port = 65535
  type = "egress"
  source_security_group_id = aws_security_group.node_sg.id  
}