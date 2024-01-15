resource "aws_eks_cluster" "my-eks-cluster" {
    name = "EKS-CLuster-Project"
    role_arn = aws_iam_role.cluster_role.arn
    vpc_config {
        subnet_ids = var.eks_subnets_id
        endpoint_private_access = true
        endpoint_public_access = true
        security_group_ids = [aws_security_group.controlplane_sg.id, aws_security_group.node_sg.id]    
    }
    depends_on = [aws_iam_role_policy_attachment.eks_cluster_role_attachment, aws_iam_role_policy_attachment.eks_cluster_vpc_role_attachment]

}

data "tls_certificate" "thumb"{
    url = aws_eks_cluster.my-eks-cluster.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.thumb.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.my-eks-cluster.identity[0].oidc[0].issuer
}
