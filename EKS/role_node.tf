data "aws_iam_policy_document" "nodes_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "node_group_role" {
    name = "node-group-eks-role"
    assume_role_policy = data.aws_iam_policy_document.nodes_assume_role_policy.json  
}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.node_group_role.name    
}
resource "aws_iam_role_policy_attachment" "cni_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.node_group_role.name    
}
resource "aws_iam_role_policy_attachment" "ecr_readOnly_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.node_group_role.name    
}
