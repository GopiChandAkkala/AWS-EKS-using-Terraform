resource "aws_eks_node_group" "eks-nodes" {
    cluster_name = aws_eks_cluster.my-eks-cluster.name
    node_role_arn = aws_iam_role.node_group_role.arn
    node_group_name = "eks-node-group"
    subnet_ids = var.eks_subnets_id
    
    instance_types = [ "t2.micro" ]

    scaling_config {
        desired_size = 2
        max_size = 2
        min_size = 2
    }
    
    depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_readOnly_policy,
  ]
}