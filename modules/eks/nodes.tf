# Nodes in private subnets
resource "aws_eks_node_group" "eks_node_private" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-Private-Node-Group"
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = var.eks_worker_private_subnet_ids

  ami_type       = var.eks_worker_ami_type      
  disk_size      = var.eks_worker_disk_size    
  instance_types = var.eks_worker_instance_types 

  remote_access {
    ec2_ssh_key = "rafig_kp"
  }

  scaling_config {
    desired_size = var.eks_worker_private_desired_size
    max_size     = var.eks_worker_private_max_size
    min_size     = var.eks_worker_private_min_size
  }

  # this is done to be sure, that roles are created before/deleted after EKS cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_ro
  ]

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-Private-Node-Group" })
}

# Nodes in public subnets
resource "aws_eks_node_group" "eks_node_public" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-Public-Node-Group"
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = var.eks_worker_public_subnet_ids

  ami_type       = var.eks_worker_ami_type       
  disk_size      = var.eks_worker_disk_size     
  instance_types = var.eks_worker_instance_types 

  remote_access {
    ec2_ssh_key = "rafig_kp"
  }

  scaling_config {
    desired_size = var.eks_worker_public_desired_size
    max_size     = var.eks_worker_public_max_size
    min_size     = var.eks_worker_public_min_size
  }

  # this is done to be sure, that roles are created before/deleted after EKS cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_ro
  ]

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-Public-Node-Group" })
}