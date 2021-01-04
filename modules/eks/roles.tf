# Roles for EKS
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-cluster-role"

  assume_role_policy = var.eks_cluster_role_policy
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = var.eks_cluster_policy_arn 
  role       = aws_iam_role.eks_cluster_role.name
}
resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = var.eks_service_policy_arn 
  role       = aws_iam_role.eks_cluster_role.name
}

# Worker Nodes roles
resource "aws_iam_role" "eks_nodes_role" {
  name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-node-role"

  assume_role_policy = var.eks_nodes_role_policy
}
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = var.eks_node_policy_arn 
  role       = aws_iam_role.eks_nodes_role.name
}
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = var.eks_node_cni_policy_arn 
  role       = aws_iam_role.eks_nodes_role.name
}
resource "aws_iam_role_policy_attachment" "ec2_container_registry_ro" {
  policy_arn = var.eks_node_ro_policy_arn 
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name   = var.eks_cluster_autoscaler_policy_name
  policy = var.eks_cluster_autoscaler_policy
}