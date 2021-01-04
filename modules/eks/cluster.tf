# ECR for EKS config
resource "aws_ecr_repository" "eks_ecr_repo" {
  name                 = lower("${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-ECR") #should be with lowercase
  image_tag_mutability = var.eks_ecr_image_tag_mutability                                               #this is needed in order to put a latest tag on the most recent image
}
# this ecr policy will keep only last 5 images
resource "aws_ecr_lifecycle_policy" "ecr_main" {
  repository = aws_ecr_repository.eks_ecr_repo.name

  policy = jsonencode(var.eks_ecr_policy)
}

# EKS cluster config
resource "aws_eks_cluster" "eks" {
  name     = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-Cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.eks_cluster_subnet_ids
    security_group_ids      = var.eks_security_groups_ids #SG ids for EKS cluster and nodes
    endpoint_private_access = var.endpoint_private_access 
    endpoint_public_access  = var.endpoint_public_access  
  }

  # this is done to be sure, that roles are created before/deleted after EKS cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy
  ]

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-Cluster" })
}